import 'package:flutter/material.dart';

var p1existe = false;
var p2existe = false;
var p3existe = true;
var p4existe = true;
var p1pic = "assets/profile_pics/profile_pic1.png";
var p2pic = "assets/profile_pics/profile_pic1.png";
var p3pic = "assets/profile_pics/profile_pic1.png";
var p4pic = "assets/profile_pics/profile_pic1.png";
var back = "assets/icons/back_icon.png";
var p1name = "noone";
var p2name = "noone2";
var p3name = "NOone3";
var p4name = "someone4";

class select_profile_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background SVG Image
          Image.asset(
            "assets/backgrounds/select_profile.jpg",
            fit: BoxFit.cover,
          ),
          Align(
                  alignment: Alignment.topLeft, 
                  child: Padding(
                  padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                      image: AssetImage(back),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                   ),
                 ),
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (p1existe)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 42),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            //add onn tap
                          },
                          child: Ink.image(
                            image: AssetImage(p1pic),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        p1name,
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.w900, // SemiBold weight
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                if (p2existe)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 42),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            //add onn tap
                          },
                          child: Ink.image(
                            image: AssetImage(p2pic),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        p2name,
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.w900, // SemiBold weight
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                if (p3existe)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 42),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            //add onn tap
                          },
                          child: Ink.image(
                            image: AssetImage(p3pic),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        p3name,
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.w900, // SemiBold weight
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                if (p4existe)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 42),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            //add onn tap
                          },
                          child: Ink.image(
                            image: AssetImage(p4pic),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        p4name,
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.w900, // SemiBold weight
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
