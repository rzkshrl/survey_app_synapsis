// ignore_for_file: invalid_use_of_protected_member

import 'package:card_swiper/card_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:survey_app_synapsis/app/theme/theme.dart';

import '../controller/api_controller.dart';
import '../data/model/survey_detailed_model.dart';

Widget buildQuestionNumberingPopup() {
  final apiC = Get.put(APIController());
  const int itemsPerPage = 20;
  var pages = List.generate(
      (apiC.questionDetailedListAllData.length / itemsPerPage).ceil(),
      (index) => buildGridView(apiC.questionDetailedListAllData.value));
  int currentPage = 0;
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: apiC.scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < apiC.questionDetailedListAllData.length;
                    i += itemsPerPage)
                  buildGridView(apiC.questionDetailedListAllData.sublist(
                      i,
                      i + itemsPerPage <=
                              apiC.questionDetailedListAllData.length
                          ? i + itemsPerPage
                          : apiC.questionDetailedListAllData.length)),
              ],
            ),
          ),
          Container(
            height: 40.0,
            child: PageView.builder(
              controller: apiC.scrollController,
              itemCount:
                  (apiC.questionDetailedListAllData.length / itemsPerPage)
                      .ceil(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor:
                        currentPage == index ? Colors.blue : Colors.grey,
                    radius: 8.0,
                  ),
                );
              },
              onPageChanged: (index) {
                // Perbarui state _currentPage sesuai dengan halaman saat ini
                currentPage = index;
              },
            ),
          ),
          // SizedBox(
          //   width: 100.w,
          //   child: PageView.builder(
          //       controller: apiC.scrollController,
          //       itemBuilder: (context, index) {
          //         return pages[index % pages.length];
          //       }),
          // ),

          // SmoothPageIndicator(
          //   controller: apiC.scrollController,
          //   count: pages.length,
          //   effect: const WormEffect(
          //     dotHeight: 16,
          //     dotWidth: 16,
          //     type: WormType.thinUnderground,
          //   ),
          // ),
        ],
      ),
    ),
  );
}

Widget buildGridView(List<QuestionDetailedModel> pageItemData) {
  final apiC = Get.put(APIController());
  return SizedBox(
    width: 100.w,
    child: GridView.builder(
      // scrollDirection: Axis.horizontal,
      // controller: apiC.scrollController,
      shrinkWrap: true,
      itemCount: pageItemData.length,
      padding:
          EdgeInsets.only(left: 6.w, top: 0.8.h, bottom: 0.8.h, right: 6.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        var item = pageItemData[index];
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
              onTap: () {
                apiC.questionDetailedListAllData.value[
                    apiC.indexQuestion.value = item.question_number! - 1];
                if (apiC.selectedOptions.contains(apiC.selectedOption.value) &&
                    apiC.selectedOptionNames
                        .contains(apiC.selectedOptionName.value) &&
                    apiC.selectedOptionQuestionIDs
                        .contains(apiC.selectedOptionQuestionID.value)) {
                  apiC.selectedOptions.clear();
                  apiC.selectedOptionNames.clear();
                  apiC.selectedOptionQuestionIDs.clear();
                }
                Get.back();
              },
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.question_number.toString(),
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
    ),
  );
}
