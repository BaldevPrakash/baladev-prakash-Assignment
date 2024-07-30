import 'package:baladev_assignment_persist_ventures_sound_of_meme/pages/log_in_log_out_sign_in_sign_out_screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../controller/login_sign_in_controller.dart';
import 'login_screen.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final LogInPageController controller = Get.isRegistered<LogInPageController>()
      ? Get.find<LogInPageController>()
      : Get.put(LogInPageController());
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => controller.isLogin ? const LoginScreen() : const SignInScreen());
  }
}
