import 'dart:developer';
import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/contact.dart';
import 'package:event_admin/utils/check_permissions.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as ct;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

///
/// Created by Auro on 26/10/22 at 2:06 AM
///

class GuestsController extends GetxController with StateMixin<List<Contact>> {
  int skip = 0, limit = 10, total = 0;
  bool shouldLoadMore = true;
  String eventId = '';
  String name = '', phone = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  bool actionLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  saveEventId(String v) {
    eventId = v;
  }

  void onNameSaved(String? newValue) {
    name = newValue!.trim();
  }

  // void onLastNameSaved(String? newValue) {
  //   lastName = newValue!.trim();
  // }

  void onPhoneSaved(String? newValue) {
    phone = newValue!.trim();
  }

  // getGuests() {
  //   change([], status: RxStatus.empty());
  // }

  removeContactLocally(Contact value) {
    List<Contact> tempList = state ?? [];
    int index = tempList.indexOf(value);
    tempList.remove(value);
    change(tempList, status: RxStatus.success());
    return index;
  }

  importFromContacts() async {
    final PermissionStatus permissionStatus =
        await CheckPermissions.getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      //We can now access our contacts here
      final contact = await ct.FlutterContacts.openExternalPick();
      Contact datum = Contact(
        name: contact!.name.first + ' ' + contact.name.last,
        phone: contact.phones.first.number,
      );
      addGuestApi(datum);
    }
  }

  addGuestLocally(Contact datum, [int? index]) {
    List<Contact> tempList = state ?? [];
    if (tempList.contains(datum)) {
      tempList.remove(datum);
    }
    tempList.insert(index ?? 0, datum);
    change(tempList, status: RxStatus.success());
  }

  void onSave() async {
    final fState = formKey.currentState;
    if (fState == null) return;
    if (!fState.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
      update();
    } else {
      fState.save();

      if (name.isEmpty) {
        SnackBarHelper.show("Name is required");
        return;
      }

      if (phone.isEmpty || !GetUtils.isPhoneNumber(phone)) {
        SnackBarHelper.show("Phone is required");
        return;
      }

      addGuestApi(Contact(
        name: name,
        phone: phone,
      ));
    }
  }

  addGuestApi(Contact datum) async {
    try {
      Map<String, dynamic> body = {
        "event": eventId,
        "guests": [
          {
            "name": datum.name,
            "phone": datum.phone,
          }
        ]
      };

      actionLoading = true;
      update();

      final result = await ApiCall.post(ApiRoutes.guests, body: body);
      log("$result");
      actionLoading = false;
      final responseDatum = Contact.fromJson(
          (result.data is List) ? result.data[0] : result.data);
      addGuestLocally(responseDatum);
      formKey.currentState!.reset();
      update();
    } catch (err, s) {
      log("$err :: $s");
      actionLoading = false;
      update();
      SnackBarHelper.show("$err");
    }
  }

  removeGuest(Contact value) async {
    int prevIndex = removeContactLocally(value);

    try {
      await ApiCall.delete(
        ApiRoutes.guests,
        id: value.id!,
        query: {
          "event": eventId,
        },
      );
    } catch (err, s) {
      log("$err :: $s");
      addGuestLocally(value, prevIndex);
      SnackBarHelper.show("$err");
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.guests,
        query: {
          "event": eventId,
          "status": 1,
          '\$sort[createdAt]': -1,
        },
      );

      final response = List<Contact>.from(
          result.data["data"].map((e) => Contact.fromJson(e)));
      if (response.length < limit) {
        shouldLoadMore = false;
      }
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void getMoreData() async {
    if (shouldLoadMore && !status.isLoadingMore) {
      skip = state!.length;
      try {
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(
          ApiRoutes.guests,
          query: {
            "event": eventId,
            "status": 1,
            '\$sort[createdAt]': -1,
          },
        );

        final response = List<Contact>.from(
            result.data["data"].map((e) => Contact.fromJson(e)));
        if (response.length < limit) {
          shouldLoadMore = false;
        }
        change((state ?? []) + response, status: RxStatus.success());
      } catch (e) {
        change(null, status: RxStatus.error(e.toString()));
      }
    }
  }
}
