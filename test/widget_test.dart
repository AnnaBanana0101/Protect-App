// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:protect_app_test/main.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Firebase Initialization Test', () async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Check if Firebase was initialized successfully
    expect(Firebase.apps.length, 1);
  });
}