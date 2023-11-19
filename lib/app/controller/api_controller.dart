// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app_synapsis/app/data/constants/api_const.dart';
import 'package:survey_app_synapsis/app/data/model/survey_model.dart';
import 'package:survey_app_synapsis/app/routes/app_pages.dart';

import '../data/model/survey_detailed_model.dart';
import '../data/model/user_model.dart';
import '../modules/login/controllers/login_controller.dart';

class APIController extends GetxController {
  final dio = Dio();
  final cookieJar = CookieJar();
  var userData = UserModel().obs;
  final loginC = Get.put(LoginController());

  var surveyListAllData = <SurveyModel>[].obs;
  var questionDetailedListAllData = <QuestionDetailedModel>[].obs;

  var visibleRequired = false.obs;

  var selectedOption = 0.obs;
  List<int> selectedOptions = [];
  var selectedOptionName = ''.obs;
  List<String> selectedOptionNames = [];
  var selectedOptionQuestionID = ''.obs;
  Set<String> selectedOptionQuestionIDs = {};

  var indexQuestion = 0.obs;

  PageController scrollController = PageController();

  int incrementIndex(int index, int listLength) {
    index++;
    if (index >= listLength) {
      index = 0;
      collectData();
      Get.back();
    }

    return index;
  }

  String buttonStateText() {
    if (questionDetailedListAllData
            .value[indexQuestion.value].question_number! ==
        questionDetailedListAllData.value.last.question_number!) {
      return 'Finish';
    } else {
      return 'Next';
    }
  }

  void removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('password');
    await Get.offAllNamed(Routes.LOGIN);
  }

  Future<List<QuestionDetailedModel>> getQuestionListData() async {
    return questionDetailedListAllData.value;
  }

  void collectData() async {
    Map<String, dynamic> dataCollectedMap = {};
    List<Map<String, dynamic>> answersListMap = [{}];

    final surveyId = questionDetailedListAllData[indexQuestion.value].survey_id;

    answersListMap = List.generate(
      selectedOptionQuestionIDs.length,
      (index) => {
        "question_id": selectedOptionQuestionIDs.toList()[index],
        "answer": selectedOptionNames[index]
      },
    );

    dataCollectedMap = {'survey_id': surveyId, 'answers': answersListMap};

    if (kDebugMode) {
      print(dataCollectedMap);
    }

    late final Directory? documentDirectory;
    if (Platform.isIOS) {
      documentDirectory = await getDownloadsDirectory();
    } else if (Platform.isAndroid) {
      documentDirectory = Directory('/storage/emulated/0/Download');
    }

    String path = '${documentDirectory!.path}/result.txt';

    var file = File(path);
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      await Permission.storage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      file.writeAsString(jsonEncode(dataCollectedMap));
      Get.snackbar(
          'File saved.', 'Result file saved on phone Downloads folder.');
    }

    if (kDebugMode) {
      print(dataCollectedMap);
    }
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
      String url = apiEndpointURL + getSurveyURL;

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
    List<SurveyModel> surveyModelList = surveyListAllData.value;
    return surveyModelList;
  }

  Future<void> getQuestionData(String surveyId, String surveyName) async {
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      String url = "$apiEndpointURL$getSurveyURL/$surveyId";

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
        questionDetailedListAllData.value =
            (res.data['data']['questions'] as List)
                .map((e) => QuestionDetailedModel.fromJson(e))
                .toList();

        Get.toNamed(Routes.SURVEY_TEST, arguments: surveyName);
      } else {
        Get.snackbar('Gagal', 'Terjadi kesalahan.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('$e');
        Get.snackbar('Gagal', 'Terjadi kesalahan.');
      }
    }
  }
}
