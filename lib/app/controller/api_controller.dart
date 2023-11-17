import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app_synapsis/app/data/constants/api_const.dart';
import 'package:survey_app_synapsis/app/data/model/survey_model.dart';
import 'package:survey_app_synapsis/app/routes/app_pages.dart';

import '../data/model/user_model.dart';
import '../modules/login/controllers/login_controller.dart';

class APIController extends GetxController {
  final dio = Dio();
  final cookieJar = CookieJar();
  var userData = UserModel().obs;
  final loginC = Get.put(LoginController());

  var surveyListAllData = <SurveyModel>[].obs;
  var questionListAllData = <QuestionModel>[].obs;

  void removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('password');
    await Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> login(String email, String password) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String url = apiEndpointURL + loginURL;

      var data = {"email": email, "password": password};
      userData.value = UserModel.fromJson(data);

      var res = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );

      if (kDebugMode) {
        debugPrint('hasil response: ${res.data}');
      }

      if (res.data['code'] == 200) {
        if (loginC.isRememberMe.value == true) {
          preferences.setString('email', userData.value.email!);

          if (kDebugMode) {
            debugPrint('preferences email : ${preferences.getString('email')}');
          }

          await Get.offAllNamed(Routes.HOME);
        } else {
          await Get.offAllNamed(Routes.HOME);
          return;
        }
      } else {
        Get.snackbar('Login Gagal', 'Periksa akun anda.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('$e');
        Get.snackbar('Login Gagal', 'Periksa akun anda.');
      }
    }
  }

  Future<List<SurveyModel>> getSurveyData() async {
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      String url = apiEndpointURL + getAllSurveyURL;

      var res = await dio.get(
        url,
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Cookie': cookie,
          },
        ),
      );

      if (res.data['code'] == 200) {
        surveyListAllData.value = List.from(res.data['data'] as List)
            .map((e) => SurveyModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar('Gagal', 'Terjadi kesalahan.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('$e');
        Get.snackbar('Gagal', 'Terjadi kesalahan.');
      }
    }
    // ignore: invalid_use_of_protected_member
    List<SurveyModel> surveyModelList = surveyListAllData.value;
    return surveyModelList;
  }
}
