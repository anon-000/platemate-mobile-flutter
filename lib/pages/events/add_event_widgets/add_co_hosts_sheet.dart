import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/pages/events/controllers/co_host_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_outline_button.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../widgets/my_background.dart';

///
/// Created by Auro on 24/10/22 at 12:47 PM
///

class AddCoHostsSheet extends StatefulWidget {
  final EventDatum datum;

  const AddCoHostsSheet(this.datum, {Key? key}) : super(key: key);

  @override
  State<AddCoHostsSheet> createState() => _AddCoHostsSheetState();
}

class _AddCoHostsSheetState extends State<AddCoHostsSheet> {
  late CoHostController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CoHostController());
    controller.onInit();
    controller.saveEventId(widget.datum.id!);
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: height * 0.1),
        child: Material(
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Color(0xff0A061D),
                  child: MyBackground(),
                ),
              ),
              GetBuilder(
                init: controller,
                builder: (c) => Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autoValidateMode.value,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        titleSpacing: 0,
                        title: Text(
                          "Co-hosts",
                          style: TextStyle(fontSize: 16),
                        ),
                        iconTheme: IconThemeData(color: Colors.white),
                      ),
                      Expanded(
                        child: ListView(
                          controller: controller.scrollController,
                          physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                onChanged: controller.onNameSaved,
                                onSaved: controller.onNameSaved,
                                // validator: (data) =>
                                //     AppFormValidators.validateEmpty(
                                //         data, context),
                                decoration:
                                    AppDecorations.textFieldDecoration_2(
                                            context)
                                        .copyWith(hintText: "Name"),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 16),
                            //   child: TextFormField(
                            //     onChanged: controller.onLastNameSaved,
                            //     onSaved: controller.onLastNameSaved,
                            //     validator: (data) =>
                            //         AppFormValidators.validateEmpty(
                            //             data, context),
                            //     decoration:
                            //         AppDecorations.textFieldDecoration_2(
                            //                 context)
                            //             .copyWith(hintText: "Last name"),
                            //   ),
                            // ),
                            // const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                onChanged: controller.onPhoneSaved,
                                onSaved: controller.onPhoneSaved,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                // validator: (data) =>
                                //     AppFormValidators.validateEmpty(
                                //         data, context),
                                decoration:
                                    AppDecorations.textFieldDecoration_2(
                                            context)
                                        .copyWith(hintText: "Phone"),
                              ),
                            ),
                            const SizedBox(height: 16),

                            if (!controller.actionLoading) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: AppPrimaryButton(
                                    child: Text("Add"),
                                    onPressed: controller.onSave,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: AppOutlineButton(
                                    child: Text(
                                      "Import from contacts",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: controller.importFromContacts,
                                  ),
                                ),
                              ),
                            ] else
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 25),
                                child: AppProgress(color: Colors.white),
                              ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 0, 10),
                                child: Text(
                                  "All Co-hosts",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            controller.obx(
                              (state) {
                                if (controller.status.isSuccess &&
                                    state != null) {
                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      controller.getData();
                                      return Future.delayed(
                                          const Duration(seconds: 2));
                                    },
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.status.isLoadingMore
                                          ? state.length + 1
                                          : state.length,
                                      separatorBuilder: (c, i) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Divider(
                                            color:
                                                Colors.grey.withOpacity(0.4)),
                                      ),
                                      itemBuilder: (context, index) {
                                        if (index >= state.length)
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        return Row(
                                          children: [
                                            Icon(Icons.contact_page_outlined),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${state[index].name!}",
                                                  ),
                                                  Text(
                                                    "+91 ${state[index].phone!}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .removeCoHost(state[index]);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.18),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              onError: (e) => AppErrorWidget(
                                  title: e ?? 'Some error occurred'),
                              onEmpty: SizedBox(
                                height: 200,
                                child: AppEmptyWidget(
                                  title: "No co-hosts yet",
                                ),
                              ),
                              onLoading: SizedBox(
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
