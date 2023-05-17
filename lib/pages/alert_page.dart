import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {

   final DatabaseReference _firebaseDatabaseRef = FirebaseDatabase.instance.ref();
  String Uid = '';

  String contactOne = '';
  String contactTwo = '';
  String contactThree = '';

  String firstNum = '';
  String secondNum = '';
  String thirdNum = '';

  List<String> recipents = [];
  List<String> receivers = ["8088231360", "8978522419"];
  String message = 'SOS: This user is in danger.';

  @override
  void initState()
  {
    super.initState();
    
    getUid();
    getContacts();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 100,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                      'Are you in danger?',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          //color: Colors.white,
                        )
                      ),
                    ),

              
            ],
          ),

          SizedBox(height: 25,),

              Text(
                'How would you like us to help?',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  )
                ),
              ),

            SizedBox(height: 75,),

            SizedBox(
              height: 70.0,
              width: 175.0,
              child: ElevatedButton(
                //On Pressed functions of the button
                onPressed: () async{
                   final  Uri url = Uri(
                    scheme: 'tel',
                    path: "112",
                   );

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }   
                    else{
                      print('Cannot launch');
                    }       
                },
                
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,                           //set padding inside the button to zero
                minimumSize: const Size(0, 0),                      //set minimum button size to zero to not interfere with given sizedbox size
                backgroundColor: Color.fromARGB(255, 250, 130, 86),
                shadowColor: Colors.white,
                //shadowColor: Color(0xFFFF7F50),
                textStyle: const TextStyle(
                  color: Colors.white
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),

                      
                child: Text('Call Police',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                )
              ), 
                      ),
            ),  

            SizedBox(height: 35,),

            SizedBox(
              height: 70.0,
              width: 175.0,
              child: ElevatedButton(
                //On Pressed functions of the button
                onPressed: () async {
                  initializeNums();
                  _sendSMS(message, recipents);                
                },
                
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,                           //set padding inside the button to zero
                minimumSize: const Size(0, 0),                      //set minimum button size to zero to not interfere with given sizedbox size
                backgroundColor: Color(0xFFF88379),
                shadowColor: Colors.white,
                //shadowColor: Color(0xFFFF7F50),
                textStyle: const TextStyle(
                  color: Colors.white
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),

                      
                child: Text('SMS Contacts',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                )
              ), 
                      ),
            ),
        ]
      ),
    );
  }

  void getUid() async {
    
    SharedPreferences s = await SharedPreferences.getInstance();

    
    Uid = s.getString("Uid").toString();
    //Uid = _firebaseAuth.currentUser?.uid;
  
    //DataSnapshot snapshot = await _firebaseDatabaseRef.child('users/$Uid/firstName').get();
    
  }

  void getContacts() async {
    
     SharedPreferences s = await SharedPreferences.getInstance();

    
     Uid = s.getString("Uid").toString();

    DataSnapshot snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactOne').get();

    contactOne = snapshot.value.toString();

    if(contactOne != '')
      firstNum = contactOne;

    snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactTwo').get();

    contactTwo = snapshot.value.toString();

    if(contactTwo != '')
      secondNum = contactTwo;

    snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactThree').get();

    contactThree = snapshot.value.toString();

    if(contactThree != '')
      thirdNum = contactThree;

    // showDialog(context: context, 
    //   builder: (context){
    //     return  AlertDialog(
    //       title: Text(firstNum),
    //   );
    //   });

    
  }

void initializeNums(){

  recipents = [firstNum, secondNum, thirdNum];
}

Future<void> _sendSMS(String message, List<String> recipents) async {
 String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
print(_result);
}

}