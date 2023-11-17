import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:survey_app_synapsis/app/controller/api_controller.dart';
import 'package:survey_app_synapsis/app/theme/theme.dart';
import 'package:survey_app_synapsis/app/utils/textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final apiC = Get.put(APIController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 8.h, left: 7.w, right: 7.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login to Synapsis',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 21.sp),
            ),
            SizedBox(
              height: 3.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 13.sp, color: grey2),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                buildFormLogin(
                  hintText: 'Email',
                  key: controller.emailFormKey.value,
                  textEditingController: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 13.sp, color: grey2),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Obx(
                  () => buildFormLogin(
                    hintText: 'Password',
                    key: controller.passFormKey.value,
                    textEditingController: controller.passC,
                    obscureText: controller.isPasswordHidden,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                        right: 1.5.w,
                      ),
                      child: IconButton(
                        color: grey,
                        iconSize: 26,
                        splashColor: Colors.transparent,
                        icon: Icon(controller.isPasswordHidden.value
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded),
                        onPressed: () {
                          controller.isPasswordHidden.value =
                              !controller.isPasswordHidden.value;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                controller.isRememberMe.value = !controller.isRememberMe.value;
              },
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isRememberMe.value,
                      onChanged: (value) {
                        controller.isRememberMe.value = value!;
                      },
                    ),
                  ),
                  Text(
                    "Remember me",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 13.sp, color: grey2),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Material(
              color: blue,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  apiC.login(controller.emailC.text, controller.passC.text);
                },
                child: SizedBox(
                  height: 6.3.h,
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'Log in',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 13.sp, color: light),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Center(
              child: Text(
                'or',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 13.sp, color: blue),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: blue, width: 0.3.w)),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {},
                child: SizedBox(
                  height: 6.3.h,
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'Fingerprint',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 13.sp, color: blue),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
