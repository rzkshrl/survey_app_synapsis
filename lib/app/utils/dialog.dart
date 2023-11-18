// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:survey_app_synapsis/app/theme/theme.dart';

import '../controller/api_controller.dart';

Widget buildQuestionNumberingPopup() {
  final apiC = Get.put(APIController());
  return Dialog(
    backgroundColor: Theme.of(Get.context!).popupMenuTheme.color,
    surfaceTintColor: Theme.of(Get.context!).popupMenuTheme.color,
    alignment: Alignment.topCenter,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    insetPadding: EdgeInsets.only(left: 0.w, right: 0.w),
    child: Container(
      height: 50.5.h,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 7.w, top: 2.h, bottom: 0.8.h, right: 7.w),
            child: Text(
              "Survei Question",
              style: Theme.of(Get.context!)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 18.sp),
            ),
          ),
          const Divider(),
          GridView.builder(
            shrinkWrap: true,
            itemCount: apiC.questionDetailedListAllData.value.length,
            padding: EdgeInsets.only(
                left: 6.w, top: 0.8.h, bottom: 0.8.h, right: 6.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 0.8.w, top: 0.4.h, bottom: 0.4.h, right: 0.8.w),
                child: Material(
                  color: light,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: grey2, width: 0.4.w),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {},
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '1',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 14.sp, color: grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
  );
}
