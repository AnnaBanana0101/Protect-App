// ignore_for_file: unused_field, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:protect_app_test/model/user_model.dart';
import 'package:protect_app_test/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../utils/utils.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final TextEditingController firstNameController=TextEditingController();    //CONTROLLER FOR FIRST NAME
  final TextEditingController lastNameController=TextEditingController();
  final FocusNode _firstFocusNode= FocusNode();
  final FocusNode _lastFocusNode= FocusNode();
  final FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
  final DatabaseReference _firebaseDatabaseRef = FirebaseDatabase.instance.ref().child("users");

  bool _isFirstEntered=false;
  bool _isLastEntered= false;


  // String? _uid;            //NULLABLE STRING
  // String get uid => _uid!; //GET UID FROM AUTH DATABSE

  // String? _phoneNumber;
  // //String get phoneNumber => _phoneNumber!;

  @override
  void initState()
  {
    super.initState();
    firstNameController.addListener(() {
      setState(() {
        _isFirstEntered= firstNameController.text.isNotEmpty;    //THE BOOL ISNUMBERENTERED GETS A BOOL VALUE FOR EMPTY STRING OR NOT
      });  
    });

    lastNameController.addListener(() {
      setState(() {
        _isLastEntered= lastNameController.text.isNotEmpty;    //THE BOOL ISNUMBERENTERED GETS A BOOL VALUE FOR EMPTY STRING OR NOT
      });  
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading= 
      Provider.of<AuthProvider>(context, listen: true).isLoading;
    return GestureDetector(

      onTap: () {
        _firstFocusNode.unfocus();
        _lastFocusNode.unfocus();

      },

      child: Scaffold(
        body: Center(
          child: _isLoading == true
          ? const Center(child: CircularProgressIndicator(
            color: Color(0xFFF88379)
          ),)
          : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //const SizedBox(height: 100),
              
                 Text(
                    "Let's get started!",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                      )
                    ),
                  ),
              
                  const SizedBox(height: 20),
                
                  Text(
                    'Enter your name',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                      )
                    ),
                  ),
              
                  const SizedBox(height: 50),
              
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal:35.0),
                      child: TextField(
                        controller: firstNameController,
                        focusNode: _firstFocusNode,
          
                        inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        ],
                        textCapitalization: TextCapitalization.words,
          
                        cursorColor: const Color(0xFFF88379),     //COLOR OF THE CURSOR IN THE TEXT FIELD
                        style: const TextStyle(                     //TEXT COLOUR IN THE TEXT FIELD
                          color: Color.fromARGB(255, 70, 70, 70),       
                        ),
            
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ), 
                      ),
                    ),
          
                const SizedBox(height: 30),
          
          
                Padding(
                padding: const EdgeInsets.symmetric(horizontal:35.0),
                child: TextField(
                  controller: lastNameController,
                  focusNode: _lastFocusNode,
          
                  inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                  ],
                  textCapitalization: TextCapitalization.words,
          
                  cursorColor: const Color(0xFFF88379),     //COLOR OF THE CURSOR IN THE TEXT FIELD
                  style: const TextStyle(                     //TEXT COLOUR IN THE TEXT FIELD
                    color: Color.fromARGB(255, 70, 70, 70),       
                  ),
              
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ), 
                ),
              ),
          
              const SizedBox(height: 20),
                
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
                            _firstFocusNode.unfocus();    //To remove focus from the number text field
                            _lastFocusNode.unfocus(); 
                            submitData();                
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
            ),
          )
        )
      ),
    );
  }

  // Future<void> insertUserData() async{

  // await _firebaseAuth.authStateChanges().firstWhere((user) => user != null);
  // User? user= _firebaseAuth.currentUser;

  // if(user!=null)
  // {
  //   _uid=user.uid;
  //   final idTokenResult= await _firebaseAuth.currentUser?.getIdTokenResult();

  //   _phoneNumber = idTokenResult?.claims!['phone_number'];

  //   Map<String, String> userData=
  // {
  //   "phoneNumber": _phoneNumber,

    
  // };
  // }
  // }

  //CALL STORE DATA AND SEND DATA TO THE REALTIME DATABSE IF BOTH THE FIELDS ARE FULL
  void submitData()
  {
    if(_isFirstEntered)
    {
      if(_isLastEntered)
      {
        storeData();
      }
      else
      {
        showSnackBar(context, "Enter Last Name");
      }
    }
    else{
      showSnackBar(context, "Enter First Name");
    }
    
  }

  void storeData() async
  {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(), 
      phoneNumber: "", 
      uid: "", 
      contactOne: "", 
      contactTwo: "", 
      contactThree: "",
    );

    authProvider.saveUserDataToFirebase(
      context: context, 
      userModel: userModel, 
      onSuccess: () {
        //ONCE DATA IS SAVED, WE NEED TO STORE IT LOCALLY AS WELL
        authProvider.saveUserDataToSharedPref().then(
          (value) => authProvider.setSignIn().then(
            (value) => Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context) => const HomePage()), 
                (route) => false
            ),
          )
        );
      }
    );

  }

}


