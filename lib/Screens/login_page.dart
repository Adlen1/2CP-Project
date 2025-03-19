import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/SelectProfilePage.dart';
import 'package:project_2cp_eq11/Screens/new_profile.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

var nopexist = false;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final userData = dataProvider.userData;

    userData['profiles']['Profile_2']['created'] = true;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //  Background SVG Image
          Image.asset("assets/backgrounds/login_page.jpg", fit: BoxFit.cover),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserInfoForm(),
                            ),
                          );
                        },
                        child: Ink.image(
                          image: AssetImage("assets/icons/add_icon.png"),
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
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SelectProfilePage(),
                              ),
                            );
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
