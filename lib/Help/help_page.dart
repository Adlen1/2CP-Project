import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Help/firstSteps.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';

class HelpPage extends StatefulWidget {
  final int profileNB;
  const HelpPage({Key? key, required this.profileNB}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
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
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "HELP",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          onTap: () {},
                          child: Ink.image(
                            image: AssetImage(
                              "assets/images/Help/bookButton.png",
                            ),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "read more",
                      style: TextStyle(
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Color(0xFF56351E),
                      ),
                    ),
                  ],
                ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FirstSteps(
                                      profileNbr: widget.profileNB,
                                    ),
                              ),
                            );
                          },
                          child: Ink.image(
                            image: AssetImage(
                              "assets/images/Help/stepsButton.png",
                            ),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "first steps",
                      style: TextStyle(
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.w900,
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
