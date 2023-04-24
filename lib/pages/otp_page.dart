// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:protect_app_test/pages/registration_page.dart';
import 'package:protect_app_test/provider/auth_provider.dart';
import 'package:protect_app_test/utils/utils.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';



class OtpPage extends StatefulWidget {
  final String verificationId;                          //THE OTP SENT TO THE DEVICE
  const OtpPage({super.key, required this.verificationId});   

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FocusNode _focusNode= FocusNode();
  String? otpCode;

  @override
  Widget build(BuildContext context) {

    final isLoading = 
      Provider.of<AuthProvider>(context, listen: true).isLoading;   //Checks if Loading

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
    
        body: Center(
          child: isLoading == true
          ? const Center(child: CircularProgressIndicator(
            color: Color(0xFFF88379)
          ),)
          : Column(
            children:  [
    
            const SizedBox(height: 100),
    
            //BACK ARROW
            Align(
              alignment: FractionalOffset.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back),
                  ),
              ),
              ),
    
    
             const SizedBox(height: 70),
    
              //VERIFICATION
              Text(
                'Verification',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 35,
                  )
                ),
              ),
    
              const SizedBox(height: 20),
    
              Text(
                'Enter the OTP',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                  )
                ),
              ),
    
    
              const SizedBox(height: 60),
    
              //INPUT OTP TEXT FIELD, DEPENDENCY ADDED TO PUBSPEC 
              Pinput(
                focusNode: _focusNode,
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFF88379),
                    )
                  )
                ),
    
                onCompleted: (value) {
                  setState(() {
                   otpCode=value; 
                  });
                },
              ),
    
    
              const SizedBox(height: 45),
    
              SizedBox(
                width: 200,
                height: 57,
                child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)]),
                            borderRadius: BorderRadius.circular(20)
                      ),
                  child: ElevatedButton(
                            //On Pressed functions of the button
                            onPressed: (){
                              if(otpCode!=null)
                              {
                                verifyOTP(context, otpCode!);
                              }
                              else
                              {
                                showSnackBar(context, "Enter the 6-Digit OTP");
                              }
                                                   
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,                           //set padding inside the button to zero
                              minimumSize: const Size(0, 0),                      //set minimum button size to zero to not interfere with given sizedbox size
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              textStyle: const TextStyle(
                                color: Colors.white
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                              
                            ),
                          
                            child: Text('Verify',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            )
                            ),
                          ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }


  void verifyOTP(BuildContext context, String userOTP)
  {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.verifyOtp(              //DEFINED IN AUTH PROVIDER
      context: context, 
      verificationId: widget.verificationId, 
      userOTP: userOTP, 
      onSuccess:(){

        authProvider.checkExistingUser().then((value) async
        {
          if(value==true)
          {
            //USER EXISTS IN THE FIRESTORE DATABASE
            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context) => const HomePage()),
                 (route) => false);
          }
          else
          {
            //NEW USER, REDIRCT TO INFO SCREEN AND ADD TO THE DB
            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context) => const RegistrationPage()),
                 (route) => false);
          }
        }
        
        );

      },
    
    );
  }
}