// ignore_for_file: unused_local_variable, non_constant_identifier_names, sort_child_properties_last, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../utils/utils.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController phone_controller=TextEditingController();    //CONTROLLER FOR PHONE NUMBER
  final FocusNode _focusNode= FocusNode();
  bool _isNumberEntered= false;
  

  //TO ADD A LISTENER TO THE PHONE TEXT FIELD CONTROLLER AND CHECK IF THE FIELD IS EMPTY
  @override
  void initState()
  {
    super.initState();
    phone_controller.addListener(() {
      setState(() {
        _isNumberEntered= phone_controller.text.isNotEmpty;    //THE BOOL ISNUMBERENTERED GETS A BOOL VALUE FOR EMPTY STRING OR NOT
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    final isLoading = 
      Provider.of<AuthProvider>(context, listen: true).isLoading;   //Checks if Loading

    return 
    GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },

      child: Container(
        decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)
                  ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: isLoading==true
            ? const Center(child: CircularProgressIndicator(
              color: Color(0xFFF88379)
            ),)
            : Column(
              children: [
                //PROTECT title
                Padding(
                  padding: const EdgeInsets.only(top:100),   //Sets only the top coordinates
                  child: Text('Protect',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 60,
                        //color: Colors.white,
                      ),
                    ),
                  ),
                ),
              
                //Your guardian angel byline
                Padding(
                  padding: const EdgeInsets.only(top:1),
                  child: Text('Your guardian angel.',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  ),
                ),
              
              
                const SizedBox(height: 50),
                
                ListView(                   //Defines the part of the scaffold that moves up when the keypad comes
                  shrinkWrap: true,
                  children: [
                      
                      Padding(
                      padding: const EdgeInsets.only(left:35, top: 10),
                      child: Text('Enter your mobile number',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                
                    const SizedBox(height:20),
                          
                          
                    //PHONE NUMBER TEXT FIELD
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:35.0),
                      child: TextField(
                        controller: phone_controller,
                        focusNode: _focusNode,
                
                        keyboardType: TextInputType.phone,         //TAKES ONLY PHONE NUMBERS
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,    
                          LengthLimitingTextInputFormatter(10)
                        ],
                          
                        cursorColor: const Color(0xFFF88379),     //COLOR OF THE CURSOR IN THE TEXT FIELD
                          
                          
                        style: const TextStyle(                     //TEXT COLOUR IN THE TEXT FIELD
                          color: Color.fromARGB(255, 70, 70, 70),       
                        ),
                          
                          
                        decoration: const InputDecoration(
                          labelText: '+91',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                          
                    const SizedBox(height:10),
                          
                    Padding(
                      padding: const EdgeInsets.only(left:35, top: 10),
                      child: Text('An OTP will be sent to the entered number',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                          
                    const SizedBox(height: 40),
                          
                    //SUBMIT button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:105.0),   //To set the width of the button (width in sized box doesn't seem to work)
                      child: SizedBox(
                        height: 57.0,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)]),
                        
                                borderRadius: BorderRadius.circular(20)
                          ),
                          child: ElevatedButton(
                            //On Pressed functions of the button
                            onPressed: (){
                              _focusNode.unfocus();    //To remove focus from the number text field
                              submitPhoneNumber();                 
                            },
                        
                            // child: Ink(
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)]),
                        
                            //     borderRadius: BorderRadius.circular(20)
                            //   ),
                        
                            child: Text('Send OTP',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            )
                            ),
                            
                        
                          
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,                           //set padding inside the button to zero
                            minimumSize: const Size(0, 0),                      //set minimum button size to zero to not interfere with given sizedbox size
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            textStyle: const TextStyle(
                              color: Colors.white
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(25)
                            ), 
                          ),
                          
                        ),
                      ),
                    )
                  ],
                ),
              
              
                
                
                
                
              ],  //Children
              ),
            )
          ),
      ),
      );
    }

    //SEND THE NUMBER TO DATABASE IF THE TEXT FIELD HAS VALID LENGTH OF NUMBER
    void submitPhoneNumber()  
    {
      if(_isNumberEntered)
      {
        String number= phone_controller.text;
        if(number.length==10)
        {
          sendPhoneNumber();
        }
        else
        {
          showSnackBar(context, "Enter a valid 10-digit phone number");
        } 
      }  
      else
      {
        showSnackBar(context, "Enter a phone number");
      }

    }

    void sendPhoneNumber() 
    {
      final authProvider= Provider.of<AuthProvider>(context, listen: false);
      String phoneNumber = phone_controller.text.trim();

      authProvider.signInWithPhone(context, "+91$phoneNumber");
    }






}
