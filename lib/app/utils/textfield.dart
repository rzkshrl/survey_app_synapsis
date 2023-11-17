import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../theme/theme.dart';

Widget buildFormLogin(
    {required String hintText,
    required Key key,
    required TextEditingController textEditingController,
    TextInputType? keyboardType,
    RxBool? obscureText,
    Widget? suffixIcon,
    String? Function(String?)? validator}) {
  RxBool isObscureText() {
    if (obscureText == null) {
      return false.obs;
    } else {
      return obscureText;
    }
  }

  return Form(
    key: key,
    child: SizedBox(
      height: 7.h,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        controller: textEditingController,
        obscureText: isObscureText().value,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 13.sp),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 20,
            left: 30,
            bottom: 20,
            right: 30,
          ),
          hintText: hintText,
          fillColor: grey4,
          filled: true,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey3, width: 1.8),
              borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey3, width: 1.8),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
    ),
  );
}
