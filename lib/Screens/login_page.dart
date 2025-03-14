import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/screens/select_profile_page.dart';


var nopexist = false;
var create_profile = "assets/icons/add_icon.png";
var select_profile = "assets/icons/select_icon.png";

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //  Background SVG Image
          Image.asset(
            "assets/backgrounds/login_page.jpg",
            fit: BoxFit.cover,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                            //CREATE PROFILE
                          },
                          child: Ink.image(
                            image: AssetImage(create_profile),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "Create",
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.w900, // SemiBold weight
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                  if (!nopexist)
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
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => select_profile_page(),
                            ));
                          },
                          child: Ink.image(
                            image: AssetImage(select_profile),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "Select",
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