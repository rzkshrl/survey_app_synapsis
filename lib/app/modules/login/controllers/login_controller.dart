// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  var isRememberMe = false.obs;
  var isPasswordHidden = true.obs;

  TextEditingController emailC = TextEditingController();
  var emailFormKey = GlobalKey<FormState>().obs;
  TextEditingController passC = TextEditingController();
  var passFormKey = GlobalKey<FormState>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
