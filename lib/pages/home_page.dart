import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:protect_app_test/pages/calm_page.dart';
import 'package:protect_app_test/pages/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

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

    //const CalmPage(),

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

            SizedBox(height: 100),
            //logo
            // DrawerHeader(
            //   child: Text(
            //         'Helplines',
            //         style: GoogleFonts.inter(
            //           textStyle: const TextStyle(
            //             fontWeight: FontWeight.w300,
            //             fontSize: 25,
            //             color: Colors.white,
            //           )
            //         ),
            //       ),
            // ),

          Text(
            'Helplines',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Colors.white,
              )
            ),
          ),

          SizedBox(height: 60,),

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: () async{
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
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Emergency Services",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
                  Text(
                    "112",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
              ],
              ),
            ),
          ),

          SizedBox(height:30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: () async{
                final  Uri url = Uri(
                    scheme: 'tel',
                    path: "100",
                   );

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }   
                    else{
                      print('Cannot launch');
                    }
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Police",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
                  Text(
                    "100",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
              ],
              ),
            ),
          ),

          SizedBox(height:30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: () async{
                final  Uri url = Uri(
                    scheme: 'tel',
                    path: "101",
                   );

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }   
                    else{
                      print('Cannot launch');
                    }
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Fire",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
                  Text(
                    "101",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
              ],
              ),
            ),
          ),

          SizedBox(height:30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(

              onTap: () async{
                final  Uri url = Uri(
                    scheme: 'tel',
                    path: "108",
                   );

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }   
                    else{
                      print('Cannot launch');
                    }
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Ambulance",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
                  Text(
                    "108",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
              ],
              ),
            ),
          ),

          SizedBox(height:30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: () async{
                final  Uri url = Uri(
                    scheme: 'tel',
                    path: "181",
                   );

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }   
                    else{
                      print('Cannot launch');
                    }
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Women's Helpline",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
                  Text(
                    "181",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
            
              ],
              ),
            ),
          ),


          ]
        ),
      ),
    );
  }
}