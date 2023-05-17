import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protect_app_test/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

  class _ContactsPageState extends State<ContactsPage> {
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  final DatabaseReference _firebaseDatabaseRef = FirebaseDatabase.instance.ref();

  final TextEditingController controller1= TextEditingController();
  final TextEditingController controller2= TextEditingController();
  final TextEditingController controller3= TextEditingController();

  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3= FocusNode();

  String Uid = '';

  String firstNum = '';
  String secondNum = '';
  String thirdNum = '';

  @override
  void initState()
  {
    super.initState();
    
    getUid();
    
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focus1.unfocus();
        focus2.unfocus();
        focus3.unfocus();
      },
      child: Scaffold(
        body:Column(
          children: [

            const SizedBox(height: 80),
    
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
    
            SizedBox(height: 50,),
    
            Text(
                    "Emergency Contacts",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      )
                    ),
                  ),
    
            SizedBox(height: 20),
    
            // Text(
            //         "Contact One",
            //         style: GoogleFonts.inter(
            //           textStyle: const TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 15,
            //           )
            //         ),
            //       ),
    
            SizedBox(height: 20),
    
            Padding(
                        padding: const EdgeInsets.symmetric(horizontal:35.0),
                        child: TextField(
                          controller: controller1,
                          focusNode: focus1,
                  
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
                            labelText: 'Contact One',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
    
                      
    
            // Text(
            //         "Contact Two",
            //         style: GoogleFonts.inter(
            //           textStyle: const TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 15,
            //           )
            //         ),
            //       ),
    
            SizedBox(height: 20),
    
            Padding(
                        padding: const EdgeInsets.symmetric(horizontal:35.0),
                        child: TextField(
                          controller: controller2,
                          focusNode: focus2,
                  
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
                            labelText: 'Contact Two',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
    
                      
    
            // Text(
            //         "Contact Three",
            //         style: GoogleFonts.inter(
            //           textStyle: const TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 15,
            //           )
            //         ),
            //       ),
    
            SizedBox(height: 20),
    
            Padding(
                        padding: const EdgeInsets.symmetric(horizontal:35.0),
                        child: TextField(
                          controller: controller3,
                          focusNode: focus3,
                  
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
                            labelText: 'Contact Three',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
    
                      SizedBox(height: 30),

                      //SUBMIT button
                    SizedBox(
                      height: 57.0,
                      width: 100.0,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)]),
                      
                              borderRadius: BorderRadius.circular(20)
                        ),
                        child: ElevatedButton(
                          //On Pressed functions of the button
                          onPressed: (){
                            focus1.unfocus();    //To remove focus from the number text field
                            focus2.unfocus(); 
                            focus3.unfocus();
                            storeNumbers();  

                            Navigator.of(context).pop();              
                          },
                          
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,                           //set padding inside the button to zero
                          minimumSize: const Size(0, 0),                      //set minimum button size to zero to not interfere with given sizedbox size
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                      
                          child: Text('Submit',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          )
                        ), 
                      ),
                        
                    ),
                    ),
          ],
        )
    
      ),
    );
  }

  void getUid() async {
    
    SharedPreferences s = await SharedPreferences.getInstance();

    
    Uid = s.getString("Uid").toString();
    //Uid = _firebaseAuth.currentUser?.uid;
  
    //DataSnapshot snapshot = await _firebaseDatabaseRef.child('users/$Uid/firstName').get();
    
  }

  void storeNumbers () async{

    firstNum = controller1.text.trim();
    secondNum = controller2.text.trim();
    thirdNum = controller3.text.trim();

    if(firstNum.length!=10)
      firstNum = '';
      //firstNum = "+91$firstNum";
    //else
    
    if(secondNum.length!=10)
      secondNum = '';
      //secondNum = "+91$secondNum";
    //else

    if(thirdNum.length!=10)
      thirdNum = '';
      //thirdNum = "+91$thirdNum";
    //else

    sendNumberOne();
    sendNumberTwo();
    sendNumberThree();

  }

  void sendNumberOne() async {
    if(firstNum != '')
     // _firebaseDatabaseRef.child('users/$Uid/contactOne').set(firstNum);
     _firebaseDatabaseRef.child('users/$Uid').update({'contactOne': firstNum});
  }

  void sendNumberTwo() async {
    if(secondNum != '')
      _firebaseDatabaseRef.child('users/$Uid').update({'contactTwo': secondNum});

  }

  void sendNumberThree() async {
    if(thirdNum != '')
      _firebaseDatabaseRef.child('users/$Uid/contactThree').set(thirdNum);
  }
}