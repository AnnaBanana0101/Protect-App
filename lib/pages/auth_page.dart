import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:protect_app_test/pages/home_page.dart';
import 'package:protect_app_test/pages/login_page.dart';
import 'package:protect_app_test/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);    //WHENEVER ANY CHANGE, AUTOMATICALLY UPDATES
    
    if(authProvider.isSignedIn==true)
    {
      return HomePage();
    }
    else
    {
      return LoginPage();
    }

    //);
  }
}