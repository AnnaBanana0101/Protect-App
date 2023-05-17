import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedTile extends StatelessWidget {
  String text;
  String heading;
  FeedTile({super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        margin: EdgeInsets.only(left:25),
        width: 280,
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
          colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)]),
          borderRadius: BorderRadius.circular(30)               
        ),
    
        child:Column(
          children: [

            SizedBox(height:60),

            Text(
            heading,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white,
              )
            ),
          ),
    
          SizedBox(height: 25),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Text(
              text,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: Colors.white,
                )
              ),
            ),
          ),
    
    
          ],
        ) 
          
      ),
    );
  }
}