// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/api_controller.dart';
import '../../../data/model/survey_detailed_model.dart';
import '../../../theme/theme.dart';
import '../../../utils/dialog.dart';
import '../../../utils/loading.dart';
import '../controllers/survey_test_controller.dart';

class SurveyTestView extends GetView<SurveyTestController> {
  const SurveyTestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final apiC = Get.put(APIController());
    var surveyName = Get.arguments;
    debugPrint(surveyName);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 2.6.w, top: 1.h, right: 2.6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: light,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: blue, width: 0.3.w)),
                child: SizedBox(
                  height: 5.h,
                  width: 40.w,
                  child: Center(
                    child: Text(
                      '45 seconds left',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 14.sp, color: blue),
                    ),
                  ),
                ),
              ),
              Material(
                color: dark,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierColor: Theme.of(context)
                            .popupMenuTheme
                            .color!
                            .withOpacity(0.4),
                        builder: (context) {
                          return buildQuestionNumberingPopup();
                        });
                  },
                  child: SizedBox(
                    height: 5.5.h,
                    width: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,
                          color: light,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          '1/3',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 14.sp, color: light),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 9.5.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: light,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: blue, width: 0.3.w),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  apiC.indexQuestion.value = 0;
                  apiC.selectedOption.value = 0;
                  apiC.visibleRequired.value = false;
                  apiC.selectedOptions.clear();
                  apiC.selectedOptionNames.clear();
                  Get.back();
                },
                child: SizedBox(
                  height: 5.5.h,
                  width: 30.w,
                  child: Center(
                    child: Text(
                      'Back',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 14.sp, color: blue),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Material(
              color: blue,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  if (apiC.selectedOption.value != 0) {
                    apiC.indexQuestion.value = apiC.incrementIndex(
                        apiC.indexQuestion.value,
                        apiC.questionDetailedListAllData.value.length);
                    apiC.selectedOptions.add(apiC.selectedOption.value);
                    apiC.selectedOptionNames.add(apiC.selectedOptionName.value);
                    apiC.selectedOptionQuestionIDs
                        .add(apiC.selectedOptionQuestionID.value);
                    debugPrint(
                        'selectedOptionName : ${apiC.selectedOptionQuestionID.value}');
                    debugPrint(
                        'selectedOptionQuestionID : ${apiC.selectedOptionName.value}');
                    // if (apiC.questionDetailedListAllData
                    //         .value[apiC.indexQuestion.value].question_number! ==
                    //     apiC.questionDetailedListAllData.value[5]
                    //         .question_number!) {
                    //   apiC.collectData();
                    // }
                    apiC.selectedOption.value = 0;
                  } else {
                    apiC.visibleRequired.value = true;
                    if (apiC.questionDetailedListAllData
                            .value[apiC.indexQuestion.value].options ==
                        null) {
                      apiC.indexQuestion.value = apiC.incrementIndex(
                          apiC.indexQuestion.value,
                          apiC.questionDetailedListAllData.value.length);
                    }
                  }
                },
                child: SizedBox(
                  height: 5.5.h,
                  width: 50.w,
                  child: Center(
                    child: Obx(
                      () => Text(
                        apiC.buttonStateText(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 14.sp, color: light),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<QuestionDetailedModel>>(
          future: apiC.getQuestionListData(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const LoadingView();
            }
            final questionDataList = snap.data!;

            return Obx(
              () => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 7.w, right: 7.w, top: 2.h, bottom: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surveyName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            '${questionDataList[apiC.indexQuestion.value].question_number!}. ${questionDataList[apiC.indexQuestion.value].question_name!}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 15.sp, color: grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 02.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(color: grey6),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 7.w, right: 7.w, top: 4.h, bottom: 1.h),
                      child: Text(
                        'Answer',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 15.sp),
                      ),
                    ),
                    Divider(
                      color: grey5,
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return ListView.builder(
                          itemCount: questionDataList[apiC.indexQuestion.value]
                                      .options ==
                                  null
                              ? 0
                              : questionDataList[apiC.indexQuestion.value]
                                  .options!
                                  .length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 0),
                          itemBuilder: (context, index) {
                            var optionItem =
                                questionDataList[apiC.indexQuestion.value]
                                    .options![index];

                            String title() {
                              if (questionDataList[apiC.indexQuestion.value]
                                      .options ==
                                  null) {
                                return '';
                              } else {
                                return optionItem.option_name.toString();
                              }
                            }

                            int? value() {
                              if (questionDataList[apiC.indexQuestion.value]
                                      .options ==
                                  null) {
                                return 0;
                              } else {
                                return optionItem.value!.toInt();
                              }
                            }

                            return GestureDetector(
                              onLongPressDown: (details) {
                                setState(() {
                                  apiC.visibleRequired.value = false;
                                  apiC.selectedOptionName.value =
                                      optionItem.option_name!;
                                  apiC.selectedOptionQuestionID.value =
                                      optionItem.question_id!;
                                  debugPrint(
                                      'selectedOptionName : ${optionItem.option_name!}');
                                  debugPrint(
                                      'selectedOptionQuestionID : ${optionItem.question_id!}');
                                  apiC.selectedOption.value = value()!;
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  title(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontSize: 15.sp),
                                ),
                                horizontalTitleGap: 0.w,
                                trailing: Obx(
                                  () => Visibility(
                                    visible: apiC.visibleRequired.value,
                                    child: Icon(
                                      FontAwesomeIcons.asterisk,
                                      color: errorBg,
                                      size: 2.w,
                                    ),
                                  ),
                                ),
                                leading: Radio(
                                  value: value(),
                                  groupValue: apiC.selectedOption.value,
                                  onChanged: (value) {
                                    setState(() {
                                      apiC.visibleRequired.value = false;
                                      apiC.selectedOptionName.value =
                                          optionItem.option_name!;
                                      apiC.selectedOptionQuestionID.value =
                                          optionItem.question_id!;
                                      debugPrint(
                                          'selectedOptionName : ${optionItem.option_name!}');
                                      debugPrint(
                                          'selectedOptionQuestionID : ${optionItem.question_id!}');
                                      apiC.selectedOption.value = value!;
                                    });
                                  },
                                ),
                              ),
                            );
                          });
                    }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
