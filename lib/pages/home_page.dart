import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:protect_app_test/pages/calm_page.dart';
import 'package:protect_app_test/pages/profile_page.dart';

import '../components/bottom_nav_bar.dart';
import 'alert_page.dart';
import 'feed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;

  void  navigateBottomBar(int index)
  {
    setState(() {
      selectedIndex=index;
    });
  }

  List<Widget> pages = [

    const AlertPage(),

    const FeedPage(),

    const CalmPage(),

    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index)),
      body: pages[selectedIndex],

      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.phone_rounded,
              color: Color(0xFFF88379),),
              onPressed: () { 
                Scaffold.of(context).openDrawer();
               },
            );
          }
        ),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFF88379),
        child: Column(
          children: [
            //logo
            DrawerHeader(
              child: Text(
                    'Helplines',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      )
                    ),
                  ),
            ),

          ]
        ),
      ),
    );
  }
}