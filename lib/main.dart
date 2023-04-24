// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:protect_app_test/firebase_options.dart';
import 'package:protect_app_test/pages/auth_page.dart';
import 'package:protect_app_test/pages/login_page.dart';
import 'package:protect_app_test/pages/otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:protect_app_test/pages/registration_page.dart';
import 'package:protect_app_test/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => AuthProvider(),
    //   child: MyApp())

    const MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:
      [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );

    // return const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //      home: AuthPage(),
    // );
  }
}

