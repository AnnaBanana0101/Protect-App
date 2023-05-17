import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  // ignore: avoid_types_as_parameter_names, prefer_typing_uninitialized_variables
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // ignore: prefer_const_constructors
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:20),
        child: GNav(
          //color: Color.fromARGB(255, 245, 210, 207),
          color: Colors.grey[400],
          //activeColor: Color(0xFFF88379),
          activeColor: Colors.grey.shade700,
          //tabActiveBorder: Border.all(color: Colors.white),
          //tabBackgroundColor: Colors.grey.shade100,
          mainAxisAlignment: MainAxisAlignment.center,
          //tabBorderRadius: 16,

          onTabChange: (value) => onTabChange!(value),

          tabs: const [
            GButton(
              icon: Icons.emergency_rounded,
              text: ' Alert',
            ),
      
            GButton(
              icon: Icons.home,
              text: ' Home',
            ),

            // GButton(
            //   icon: Icons.ac_unit_rounded,
            //   text: ' Calm',
            // ),

            GButton(
              icon: Icons.person_rounded,
              text: ' Profile',
            )
      
          ], 
        ),
      ),
    );
  }
}