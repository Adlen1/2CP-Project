import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/screens/SelectProfilePage.dart';
import 'package:project_2cp_eq11/Screens/new_profile_page.dart';

var nopexist = false;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //  Background SVG Image
          Image.asset(
            "assets/backgrounds/bg1.jpg",
            fit: BoxFit.cover,
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "WELCOME",  
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 42),
                    Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => NewProfilePage()));
                          },
                          child: Ink.image(
                            image: AssetImage("assets/icons/add_icon.png"),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
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
                              pageBuilder: (context, animation, secondaryAnimation) => SelectProfilePage(),
                            ));
                          },
                          child: Ink.image(
                            image: AssetImage("assets/icons/select_icon.png"),
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
