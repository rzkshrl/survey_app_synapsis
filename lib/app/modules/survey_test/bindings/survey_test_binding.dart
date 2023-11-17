import 'package:get/get.dart';

import '../controllers/survey_test_controller.dart';

class SurveyTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyTestController>(
      () => SurveyTestController(),
    );
  }
}
