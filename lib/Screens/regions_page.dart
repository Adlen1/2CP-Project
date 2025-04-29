import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/Region1Adv1.dart';
import 'package:project_2cp_eq11/Screens/Region1/region1Adv2.dart';
import 'package:project_2cp_eq11/Screens/Region2/region2Adv1.dart';
import 'package:project_2cp_eq11/Screens/Region2/region2Adv2.dart';
import 'package:project_2cp_eq11/Screens/Region3/region3Adv1.dart';
import 'package:project_2cp_eq11/Screens/level0_page.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class RegionsPage extends StatefulWidget {
  final int profileNbr;
  final int directRegion;

  const RegionsPage({
    Key? key,
    required this.profileNbr,
    required this.directRegion,
  }) : super(key: key);

  @override
  _RegionsPageState createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage>
    with SingleTickerProviderStateMixin {
  List<String> regions = [];
  int? selectedAdventure;
  late int selectedRegion;

  Future<void> _adjustVolume(double volume) async {
    await MusicController().setVolume(volume);
  }

  String get currentRegion {
    return regions[selectedRegion];
  }

  final Map<String, List<Map<String, dynamic>>> regionButtons = {
    "LEVEL_0": [],

    "NORTH": [
      {"left": 0.35, "top": 0.35, "adventure": 2},
      {"left": 0.17, "top": 0.5, "adventure": 1},
    ],
    "EAST": [
      {"left": 0.25, "top": 0.4, "adventure": 1},
      {"left": 0.42, "top": 0.45, "adventure": 2},
    ],
    "WEST": [
      {"left": 0.28, "top": 0.48, "adventure": 1},
      {"left": 0.38, "top": 0.28, "adventure": 2},
    ],
    "SOUTH": [
      {"left": 0.42, "top": 0.42, "adventure": 1},
      {"left": 0.58, "top": 0.22, "adventure": 2},
    ],
  };

  void changeRegion(int direction) {
    setState(() {
      selectedRegion = selectedRegion + direction;

      if (selectedRegion < 0) {
        selectedRegion = regions.length - 1;
      } else if (selectedRegion >= regions.length) {
        selectedRegion = 0;
      }
      selectedAdventure = null;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRegion = widget.directRegion;

    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    final age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;

    if (age < 7) {
      regions.add("LEVEL_0");
    }
    regions.addAll(["NORTH", "EAST", "WEST", "SOUTH"]);
    changeRegion(0);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg8.jpg", fit: BoxFit.fill),
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
                        Navigator.pop(context);
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      regions[selectedRegion],
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF56351E),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/icons/regions_page/${regions[selectedRegion]}.png",
                          ),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedGameButton(
            "assets/icons/regions_page/left_triangle.png",
            screenWidth * 0.18,
            screenHeight * 0.18,
            screenWidth * 0.02,
            screenHeight * 0.4,
            onTap: () {
              setState(() {
                changeRegion(-1);
              });
            },
          ),

          AnimatedGameButton(
            "assets/icons/regions_page/right_triangle.png",
            screenWidth * 0.18,
            screenHeight * 0.18,
            screenWidth * 0.8,
            screenHeight * 0.4,
            onTap: () {
              setState(() {
                changeRegion(1);
              });
            },
          ),

          ...regionButtons[currentRegion]!.asMap().entries.map((entry) {
            int index = entry.key + 1;
            bool isUnlocked = false;
            Map<String, dynamic> buttonData = entry.value;
            if (index == 1) {
              isUnlocked =
                  userData["Profiles"]["Profile_${widget.profileNbr}"]["Regions"]["region_${regions[selectedRegion].toLowerCase()}"]["unlocked"] ==
                  true;
            }
            if (index == 2) {
              isUnlocked =
                  userData["Profiles"]["Profile_${widget.profileNbr}"]["Regions"]["region_${regions[selectedRegion].toLowerCase()}"]["adventures"]["adventure_1"]["completed"] ==
                  true;
            }

            String iconPath;
            if (!isUnlocked) {
              iconPath = "assets/icons/regions_page/locked_adventure.png";
            } else if (userData["Profiles"]["Profile_${widget.profileNbr}"]["Regions"]["region_${regions[selectedRegion].toLowerCase()}"]["adventures"]["adventure_$index"]["completed"]) {
              iconPath = "assets/icons/regions_page/${index}compeleted.png";
            } else {
              iconPath = "assets/icons/regions_page/${index}unlocked.png";
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                if (selectedAdventure != null && selectedAdventure == index)
                  Positioned(
                    left: screenWidth * buttonData["left"] - 8.5,
                    top: screenHeight * buttonData["top"] - 3.5,
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF53C8C1),
                          width: 3,
                        ),
                      ),
                    ),
                  ),

                AnimatedGameButton(
                  iconPath,
                  screenWidth * 0.18,
                  screenHeight * 0.18,
                  screenWidth * buttonData["left"],
                  screenHeight * buttonData["top"],
                  onTap:
                      isUnlocked
                          ? () {
                            setState(() {
                              selectedAdventure = index;
                            });
                          }
                          : null,
                ),
              ],
            );
          }).toList(),

          if (selectedRegion != "LEVEL_0") ...[
            AnimatedGameButton(
              "assets/icons/regions_page/select_button.png",
              screenWidth * 0.2,
              screenHeight * 0.2,
              screenWidth * 0.4,
              screenHeight * 0.8,
              onTap: () async {
                if (selectedAdventure != null) {
                  final adventureData =
                      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${currentRegion.toLowerCase()}"]["adventures"]["adventure_$selectedAdventure"];

                  final alreadyStarted =
                      adventureData["alreadyStarted"] ?? false;

                  int initIndex = 0;

                  if (alreadyStarted) {
                    final result = await ValidationDialog.show(
                      context: context,
                      title: "Adventure started already!",
                      message:
                          "Do you want to continue the adventure or restart?",
                      iconPath: "assets/icons/fennec/fennec_settings_icon.png",
                      buttons: [
                        DialogButtonData(
                          text: "Restart",
                          color: Colors.redAccent,
                          onTap: () => Navigator.pop(context, 'restart'),
                        ),
                        DialogButtonData(
                          text: "Continue",
                          color: Colors.greenAccent,
                          onTap: () => Navigator.pop(context, 'continue'),
                        ),
                      ],
                    );

                    if (result == 'continue') {
                      initIndex = adventureData["checkPoint"] ?? 0;
                    } else if (result == 'restart') {
                      initIndex = 0;
                    } else {
                      return;
                    }
                  } else {
                    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${currentRegion.toLowerCase()}"]["adventures"]["adventure_$selectedAdventure"]["alreadyStarted"] =
                        true;
                  }

                  Widget? nextScreen;
                  if (currentRegion == "NORTH") {
                    if (selectedAdventure == 1) {
                      nextScreen = Region1Adv1(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    } else if (selectedAdventure == 2) {
                      nextScreen = Region1Adv2(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    }
                  } else if (currentRegion == "EAST") {
                    if (selectedAdventure == 1) {
                      nextScreen = Region2Adv1(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    } else if (selectedAdventure == 2) {
                      nextScreen = Region2Adv2(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    }
                  } else if (currentRegion == "WEST") {
                    if (selectedAdventure == 1) {
                      nextScreen = Region3Adv1(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    } else if (selectedAdventure == 2) {
                      nextScreen = Region3Adv1(
                        profileNbr: widget.profileNbr,
                        region: currentRegion,
                        adventure: selectedAdventure!,
                        initIndex: initIndex,
                      );
                    }
                  }

                  // Navigate if nextScreen is set
                  if (nextScreen != null) {
                    _adjustVolume(0.2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => nextScreen!),
                    ).then((_) {
                      _adjustVolume(0.4);
                    });
                  }
                }
              },
            ),
          ],

          // LEVEL 0 Special Button
          if (regions[selectedRegion] == "LEVEL_0") ...[
            Positioned(
              top: screenHeight * 0.8,
              left: screenHeight * 0.85,
              child: GestureDetector(
                onTap: () {
                  _adjustVolume(0.2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => Level0(profileNbr: widget.profileNbr),
                    ),
                  ).then((_) {
                    _adjustVolume(0.4);
                  });
                },
                child: Image.asset(
                  "assets/icons/confirm_icon.png",
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.2,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
