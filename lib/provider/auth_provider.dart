// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:protect_app_test/model/user_model.dart';
import 'package:protect_app_test/pages/otp_page.dart';
import 'package:protect_app_test/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

//To check if the user is signed in. If not, redirect to login page and then check existing or not and so on.

class AuthProvider extends ChangeNotifier{

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;            //NULLABLE STRING
  String get uid => _uid!; //GET UID FROM AUTH DATABASE

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  //final FirebaseFirestore _firebaseFirestore= FirebaseFirestore.instance;
  DatabaseReference _firebaseDatabaseRef = FirebaseDatabase.instance.ref();


  AuthProvider()
  {
    checkSignedIn();        //FUNCTION TO CHECK IF THE USER ALREADY SIGNED IN
  }

  //CHECK IF SIGNED IN
  void checkSignedIn() async {         //ASYNC BECAUSE USING SHARED PREFERENCES
    
    final SharedPreferences sharedpref =  await SharedPreferences.getInstance();
    _isSignedIn= sharedpref.getBool("is_signedin") ?? false;       //IF THE KEY EXISTS IN THE DEVICE (I.E ALREADY SIGNED IN), RETURN TRUE. OTHERWISE, RETURN FALSE. KEY= "is_signedin"
    notifyListeners();

  }

  //SET KEY TO IS_SIGNEDIN TO TRUE
  Future setSignIn() async{
    final SharedPreferences sharedpref =  await SharedPreferences.getInstance();
    sharedpref.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  //SIGN IN
  void signInWithPhone(BuildContext context, String phoneNumber) async         //ASYNC FUNCTION BECAUSE WE WILL USE AWAIT
  {
    try{
      //VERIFY THE PHONE NUMBER ENTERED AND PERFORM THE REQUIRED TASK BSED ON CASE
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //1.THE NUMBER IS VERIFIED, WHEN THE SMS CODE DELIVERED TO DEVICE, ANDROID AUTOMATICALLY VERIFIES THE SMS CODE. 
        //IF THIS EVENT OCCURS, A PHONEAUTHCREDENTIAL IS AUTOMATICALLY PROVIDED TO SIGN-IN WITH PHONE NUMBER
        verificationCompleted:(PhoneAuthCredential phoneAuthCredential) async{
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },

        //2.FIREBASE RETURNS AN ERROR, EG IF INCORRECT PHONE NUMBER OR SMS 
        //QUOTA FOR THE PROJECT HAS EXPIRED. IT THROWS THE ERROR MESSAGE TO THE USER.
        verificationFailed: (error){
          throw Exception(error.message); 
        }, 

        //3.ONCE THE VERIFICATION ID (OTP) HAS BEEN SENT TO THE DEVICE, REDIRECT THE USER TO THE OTP SCREEN
        codeSent: ((verificationId, forceResendingToken) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => OtpPage(verificationId: verificationId)  //VERIFICATION ID=OTP
            )
          ); 
        }), 


        //4. 
        codeAutoRetrievalTimeout: (verificationId) {
        }

        
        
      );
    } 
    on FirebaseAuthException catch (e)
    {
      showSnackBar(context, e.message.toString());             //SHOW THE EXCEPTION MESSAGE FROM FIREBASE AUTH ON THE SNACKBAR. SNACKBAR IN UTILS
    }
  }
  
  
  //VERIFY OTP ENTERED BY THE USER
  void verifyOtp(
    {
    required BuildContext context, 
    required String verificationId,
    required String userOTP,
    required Function onSuccess
    }
  ) async {

    _isLoading =true;
    notifyListeners();

    try{
      PhoneAuthCredential creds= PhoneAuthProvider.credential   //USER CREDENTIALS, VERIFICATION ID AND THE OTP ENTERED
      (verificationId: verificationId, smsCode: userOTP);

      User? user= (await _firebaseAuth.signInWithCredential(creds)).user!;  //GET THE USER RETURNED THROUGH THE SIGNINWITHCREDENTIAL COMMAND 

      if(user!=null)   //IF THE USER EXISTS I.E THE USER ENTERED THE CORRECT OTP AND GOTADDED TO THE DB
      {
        //CARRY OUR LOGIC
        _uid= user.uid;      //GETTING THE UID OF THE USER FROM AUTH DATABASE
        onSuccess();
      }
      _isLoading= false;
    } 
    on FirebaseAuthException catch (e)
      {
        showSnackBar(context, e.message.toString());
        _isLoading=false;
        notifyListeners();
      }


  }

  //DATABASE OPERATIONS
  // Future<bool> checkExistingUser () async
  // {

  //   //CHECK THE FIRESTORE DATABASE TO SEE IF THE USER WITH THE GIVEN UID(FROM AUTH) EXISTS.
  //   DocumentSnapshot snapshot= 
  //     //await _firebaseFirestore.collection("users").doc(_uid).get();

  //   if(snapshot.exists)
  //   {
  //     print("USER EXISTS");
  //     return true;
  //   }
  //   else
  //   {
  //     print("NEW USER");
  //     return false;
  //   }
  // }



  //DATABSE OPERATIONS


  Future<bool> checkExistingUser () async
  {

    //CHECK THE FIRESTORE DATABASE TO SEE IF THE USER WITH THE GIVEN UID(FROM AUTH) EXISTS.
    String UID='';
    String? Uid;
     if(_uid!=null)
     {
      Uid= _firebaseAuth.currentUser?.uid;
      UID= _uid!;
     }   
    //final snapshot = await _firebaseDatabaseRef.child('users/$_uid').get();
    final snapshot = await _firebaseDatabaseRef
    .child('users').child(Uid!)
    .get();

    if (snapshot.exists) {
        print(snapshot.value);
        return true;
    } else {
      //TODO: ADD THE UID AND USER TO THE REALTIME DATABASE
        print('No data available.');
        return false;
    }

  }

  void saveUserDataToFirebase({
    required BuildContext context, 
    required UserModel userModel, 
    required Function onSuccess
  }) async {
    _isLoading=true;
    notifyListeners();

    try{
      //UPLOAD TO DATABASE
      userModel.phoneNumber= _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid= _firebaseAuth.currentUser!.uid;

      await _firebaseDatabaseRef
      .child('users/$_uid')
      .set(userModel.toMap())
      .then((value) {
        onSuccess();
        _isLoading=false;
        notifyListeners();
      });

    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading=false;
      notifyListeners();
    }
  }



  //STORING DATA LOCALLY
  Future saveUserDataToSharedPref() async {
    SharedPreferences s= await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel?.toMap()));
  }

}