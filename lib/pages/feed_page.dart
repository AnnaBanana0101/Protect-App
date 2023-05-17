import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protect_app_test/pages/feed_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  List<List<String>> tips = [  ['Create a distraction', 'In case of an attack, create a distraction by shouting, throwing an object, or making a loud noise.'],
  ['Hit vulnerable areas', 'If you have to defend yourself, aim for vulnerable areas such as the eyes, nose, throat, or groin.'],
  ['Zigzag run', 'If chased, run in a zigzag pattern to make it harder for the attacker to catch you.'],
  ['Use your voice', 'Shout "fire" instead of "help" as it is more likely to get attention and draw help.'],
  ['Find a safe place', 'If you are being followed, try to go to a public place with other people around, such as a store or restaurant.'],
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 20),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Text(
                  'Welcome!',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      //color: Colors.white,
                    )
                  ),
                ),
              ),
            ],
          ),

          //SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/images/Protect-doggo-nobg.png',
              height: 120,
              ),
            ],
          ),
          //SizedBox(height: 100),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Your well-being is of utmost importance. Here are some helpful tips for you in times of panic: ',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Color.fromARGB(255, 76, 99, 110),
                      ))
                    ),
          ),

          SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              itemCount: tips.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                //String heading = 'Create a distraction';
                //String text = 'In case of an attack, create a distraction by shouting, throwing an object, or making a loud noise.';
                String heading = tips[index][0];
                String text = tips[index][1];
          
                return FeedTile(heading: heading, text: text);
                
              }),
          ),

          SizedBox(height:40),
        ]
      )
    );;
  }
}