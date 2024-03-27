import 'package:date/api/notification.dart';
import 'package:date/controller/auth_controller.dart';
import 'package:date/view/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'view/auth/AuthScreen.dart';
import 'view/home/home_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  // Handle the received message here
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51OFYhgD9rzaCJql7AjrTQ62gcDfKB7qv0Gh5zbzfuBv0HRrsylwGUh5eHiuMHtwanajw6iMxLYPGud7km1m3oHbH007AjXB7X9";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyD3kxU-VND-wSKYFc_pxgPUR72ByT0NPdM",
              appId: "1:832945625672:android:a96b7bf5f05db854b7967d",
              messagingSenderId: "832945625672",
              projectId: "date-50347",
              storageBucket: "date-50347.appspot.com"))
      .then((value) {
    Get.put(AuthenticationController());
  });

  // FirebaseApi().initNotification();
  // await PushNotificationSystems().initNotification();
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
