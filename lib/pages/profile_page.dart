import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protect_app_test/pages/contacts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {


final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
final DatabaseReference _firebaseDatabaseRef = FirebaseDatabase.instance.ref();
String userName = '';
String firstName = '';
String lastName = '';
String Uid = '';

String contactOne = '';
String contactTwo = '';
String contactThree = '';

String number = '';



late TextEditingController controller1;

@override
  void initState()
  {
    super.initState();
    
    displayName();
    displayNumber();
    displayContacts();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: 30,),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Image.asset('lib/images/Protect-nobg.png',
              //height: 240,
              ),
            ),

          SizedBox(height: 30,),

          Text(
                  userName,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 19,
                    )
                  ),
                ),

          SizedBox(height: 10,),

          Text(
                  number,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    )
                  ),
                ),

          SizedBox(height: 40,),
          
          Text(
                  "Emergency Contacts",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    )
                  ),
                ),

          

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:30.0),
            
            child: Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>   Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ContactsPage()  
                )
                ),
                  child: Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),


          SizedBox(height: 30,),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Contact One",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

                Text(
                  contactOne,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

            ],
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Contact Two",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

                Text(
                  contactTwo,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

            ],
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Contact Three",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

                Text(
                  contactThree,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFF88379)
                    )
                  ),
                ),

            ],
            ),
          ),

        ],
      )
    );
  }

 void displayName() async {
    
    SharedPreferences s = await SharedPreferences.getInstance();

    
    Uid = s.getString("Uid").toString();
    //Uid = _firebaseAuth.currentUser?.uid;
    
    

    DataSnapshot snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/firstName').get();

    firstName = snapshot.value.toString();

    snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/lastName').get();

    lastName = snapshot.value.toString();

    setState(() {
      userName = firstName+" "+lastName;
    });
    
   
    
  }

  void displayNumber() async {
    
    SharedPreferences s = await SharedPreferences.getInstance();

    
    Uid = s.getString("Uid").toString();

    DataSnapshot snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/phoneNumber').get();

    setState(() {
      number = snapshot.value.toString();
    });
    //number = snapshot.value.toString();
    
  }

  void displayContacts() async {
    
    SharedPreferences s = await SharedPreferences.getInstance();

    
    Uid = s.getString("Uid").toString();

    DataSnapshot snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactOne').get();

    setState(() {
      contactOne = snapshot.value.toString();
    });
    

    snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactTwo').get();

    setState(() {
      contactTwo = snapshot.value.toString();

    });
    
    snapshot = await _firebaseDatabaseRef
    .child('users/$Uid/contactThree').get();

    setState(() {
      contactThree = snapshot.value.toString();
    });
    
    
  }



  

}