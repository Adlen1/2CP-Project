import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class RegionsPage extends StatefulWidget {
  final int profileNbr;
  final int directRegion;

  const RegionsPage({
    Key? key,
    required this.profileNbr,
    this.directRegion = 0, 
  }) : super(key: key);

  @override
  _RegionsPageState createState() => _RegionsPageState();
}


class _RegionsPageState extends State<RegionsPage> with SingleTickerProviderStateMixin {

  List<String> regions = ["NORTH", "EAST", "WEST", "SOUTH"];
  int currentRegionIndex = 0;
  int? selectedAdventure ;
  String get currentRegion => regions[currentRegionIndex];

  final Map<String, List<Map<String, dynamic>>> regionButtons = {
  "NORTH": [
    {"left": 0.17, "top": 0.5,"adventure": 1},
    {"left": 0.35, "top": 0.35,"adventure": 2},
  ],
  "EAST": [
    {"left": 0.25, "top": 0.4,"adventure": 1},
    {"left": 0.42, "top": 0.45,"adventure": 2},
  ],
  "WEST": [
    {"left": 0.28, "top": 0.48,"adventure": 1},
    {"left": 0.38, "top": 0.28,"adventure": 2},
  ],
  "SOUTH": [
    {"left": 0.42, "top": 0.42,"adventure": 1},
    {"left": 0.58, "top": 0.22,"adventure": 2},
  ],
};


  void changeRegion(int direction) {
    setState(() {
      currentRegionIndex = (currentRegionIndex + direction) % regions.length;
      if (currentRegionIndex < 0) currentRegionIndex = regions.length - 1;

      selectedAdventure = null;
    });
  }

  @override
  void initState() {
    super.initState();
    changeRegion(widget.directRegion);
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
            child: Image.asset(
              "assets/backgrounds/bg8.jpg",
              fit: BoxFit.fill,
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Text Container
                  Align(
                    alignment: Alignment.topCenter, 
                    child: Text(
                      regions[currentRegionIndex],  
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: MediaQuery.of(context).size.width * 0.045, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF56351E),
                      ),
                    ),
                  ),
                  SizedBox(height: 25), 
                  // Image Container
                  Align(
                    alignment: Alignment.center, 
                    child: Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        child: Ink.image(
                          image: AssetImage("assets/icons/regions_page/${regions[currentRegionIndex]}.png"),
                          height: MediaQuery.of(context).size.height * 0.6, 
                          width: MediaQuery.of(context).size.width * 0.6, 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedGameButton("assets/icons/regions_page/left_triangle.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.02, screenHeight * 0.4,onTap: () { 
              setState(() {
                changeRegion(-1);
              });
            },),
          AnimatedGameButton("assets/icons/regions_page/right_triangle.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.8, screenHeight * 0.4,onTap: () { 
              setState(() {
                changeRegion(1);
              });
            },),

            ...regionButtons[currentRegion]!.asMap().entries.map((entry) {
              int index = entry.key + 1; 
              bool isUnlocked = false ;
              Map<String, dynamic> buttonData = entry.value;
              if(index == 1){
                isUnlocked = userData["Profiles"]["Profile_${widget.profileNbr}"]["Regions"]["region_${regions[currentRegionIndex].toLowerCase()}"]["unlocked"] == true;
              }
              if(index == 2){
                isUnlocked = userData["Profiles"]["Profile_${widget.profileNbr}"]["Regions"]["region_${regions[currentRegionIndex].toLowerCase()}"]["adventures"]["adventure_1"]["completed"] == true;
              }



              String iconPath = isUnlocked
                  ? "assets/icons/regions_page/unlocked_adventure.png"
                  : "assets/icons/regions_page/locked_adventure.png";

              return Stack(
                alignment: Alignment.center,
                children: [
                  if (selectedAdventure != null && selectedAdventure == index)
                    Positioned(
                      left: screenWidth * buttonData["left"] - 8, // Adjust for centering
                      top: screenHeight * buttonData["top"] - 3,
                      child: Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF53C8C1), width: 4),
                        ),
                      ),
                    ),

                  // Adventure Button
                  AnimatedGameButton(
                    iconPath,
                    screenWidth * 0.18,
                    screenHeight * 0.18,
                    screenWidth * buttonData["left"],
                    screenHeight * buttonData["top"],
                    onTap: isUnlocked
                        ? () {
                            setState(() {
                              selectedAdventure = index; // Set the selected adventure
                            });
                          }
                        : null, // Disable button if locked
                  ),
                ],
              );
            }).toList(),

            AnimatedGameButton("assets/icons/regions_page/select_button.png", screenWidth * 0.2, screenHeight * 0.2, screenWidth * 0.4, screenHeight * 0.8,onTap: () {})

        ]
      )
    );
  }


}