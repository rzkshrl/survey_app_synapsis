import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:survey_app_synapsis/app/routes/app_pages.dart';
import 'package:survey_app_synapsis/app/utils/loading.dart';

import '../../../controller/api_controller.dart';
import '../../../data/model/survey_model.dart';
import '../../../theme/theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final apiC = Get.put(APIController());
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 2.6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Halaman Survei',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 17.sp),
              ),
              IconButton(
                onPressed: () {
                  apiC.removePreferences();
                },
                color: blue,
                iconSize: 26,
                splashColor: Colors.transparent,
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<SurveyModel>>(
          future: apiC.getSurveyData(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const LoadingView();
            }
            final surveyDataList = snap.data!;
            var formatter = DateFormat('d MMMM yyyy', 'id-ID');
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 7.w, right: 7.w),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 1.8.h),
                    itemCount: surveyDataList.length,
                    itemBuilder: (context, index) {
                      var survey = surveyDataList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Material(
                          color: light,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: grey5, width: 0.3.w)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              Get.toNamed(Routes.SURVEY_TEST,
                                  arguments: survey);
                            },
                            child: SizedBox(
                              height: 10.h,
                              width: double.maxFinite,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      PhosphorIconsRegular.exam,
                                      color: blue,
                                      size: 16.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          survey.survey_name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(fontSize: 13.sp),
                                        ),
                                        SizedBox(
                                          height: 0.6.h,
                                        ),
                                        Text(
                                          'Created At: ${formatter.format(survey.created_at!)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                  fontSize: 11.sp,
                                                  color: green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
