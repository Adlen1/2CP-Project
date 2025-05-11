import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/main_page.dart';
import 'package:project_2cp_eq11/Screens/new_profile_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:provider/provider.dart';

var back = "assets/icons/back_icon.png";

/// ============================================================================
/// changeProfile.dart
/// ============================================================================
///
/// this is where you can either create a new profile, or select an existing profile.
///
///
/// pushed by settings_page.dart
///
/// ============================================================================

class ChangeProfile extends StatefulWidget {
  final int profileNbr;
  const ChangeProfile({super.key, required this.profileNbr});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final userData = dataProvider.userData;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background SVG Image
          Image.asset("assets/backgrounds/bg2.jpg", fit: BoxFit.fill),

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
                    "Profiles",
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
                if (!userData['Profiles']["Profile_1"]['created'] ||
                    !userData['Profiles']["Profile_2"]['created'] ||
                    !userData['Profiles']["Profile_3"]['created'] ||
                    !userData['Profiles']["Profile_4"]['created'])
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
                                  builder: (context) => NewProfilePage(),
                                ),
                              );
                            },
                            child: Ink.image(
                              image: AssetImage(
                                "assets/icons/login_page/add_icon.png",
                              ),
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
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                for (int i = 1; i < 5; i++)
                  if (userData['Profiles']["Profile_$i"]['created'] &&
                      i != widget.profileNbr)
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MainScreen(profileNbr: i),
                                ),
                              );
                            },
                            child: Ink.image(
                              image: AssetImage(
                                "assets/icons/profile_pics/profilePic${userData['Profiles']["Profile_$i"]['avatar'].toString()}.png",
                              ),
                              height: 140,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          userData['Profiles']["Profile_$i"]['firstName'],
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
