import 'package:baladev_assignment_persist_ventures_sound_of_meme/pages/log_in_log_out_sign_in_sign_out_screens/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';
import 'constants/consts.dart';
import 'controller/login_sign_in_controller.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = stripePublishableKey;
  // await _setup();
  runApp(const MyApp());
// Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//...
}

/*void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}*/

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final LogInPageController controller = Get.isRegistered<LogInPageController>()
      ? Get.find<LogInPageController>()
      : Get.put(LogInPageController());
  @override
  Widget build(BuildContext context) {
    controller.initialiseVariables();
    controller.setIsLogin(true);
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
