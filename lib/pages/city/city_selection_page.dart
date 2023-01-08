import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/pages/authenticaton/controllers/city_selection_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 01/12/22 at 7:46 AM
///

class CitySelectionPage extends StatefulWidget {
  static const routeName = '/city-selection';

  const CitySelectionPage({Key? key}) : super(key: key);

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  late CitySelectionController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<CitySelectionController>()
        ? Get.find<CitySelectionController>()
        : Get.put(CitySelectionController());
    if (controller.state == null) {
      controller.getCities();
    }
    controller.initCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your city'),
        // iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
      ),
      body: controller.obx(
        (state) {
          if (state != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) => ListTile(
                      onTap: () {
                        controller.onCitySelect(state[i]);
                      },
                      leading: Icon(
                        Icons.location_on,
                        size: 24,
                        color: controller.selectedCity == null
                            ? AppColors.grey
                            : controller.selectedCity!.value.id == state[i].id
                                ? AppColors.brightSecondaryColor
                                : AppColors.grey,
                      ),
                      title: Text(
                        '${state[i].name}',
                        style: TextStyle(
                          color: controller.selectedCity == null
                              ? AppColors.grey
                              : controller.selectedCity!.value.id == state[i].id
                                  ? AppColors.brightSecondaryColor
                                  : AppColors.grey,
                        ),
                      ),
                    ),
                    itemCount: state.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppPrimaryButton(
                      child: Text("Save"),
                      onPressed: controller.onCitySaved,
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
        onError: (e) => AppErrorWidget(title: e ?? 'Some error occurred'),
        onEmpty: AppEmptyWidget(
          title: "No City found",
        ),
        onLoading: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
