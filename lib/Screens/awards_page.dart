import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class AwardsPage extends StatefulWidget {
  final int profileNbr;

  const AwardsPage({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _AwardsPageState createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  String selectedRegion = "";
  String selectedAdventure = "";

  @override
  void initState() {
    super.initState();

    // Fennec Animation with Bounce Effect
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
  }

  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

  void handleTrophyClick(String region, String adv) {
    setState(() {
      selectedRegion = region;
      selectedAdventure = adv;
    });
  }

  Widget showInfoTrofie(String region, String adventure) {
    final userData = Provider.of<DataProvider>(context).userData;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double regionTextContainerWidth = screenWidth * 0.135;
    double discriptionContainerWidth = screenWidth * 0.38;
    double discriptionContainerHeight = screenHeight * 0.48;
    int adNb = 0;
    double trophySize; // Increased trophy size
    double offsetHeight;
    double offsetWidth = 0;

    double trophieContainerWidth = screenWidth * 0.24;
    double trophyContainerHeight =
        screenHeight * 0.6; // Keep the original height
    String text1 = "";
    String text2 = "";
    if (adventure == "") {
      switch (region) {
        case 'North':
          trophySize = screenHeight * 0.7;
          offsetHeight = 1;
          text1 =
              "A long time ago, a shiny golden trophy was made for the bravest explorers and hidden deep in Northern Algeria.";
          text2 = "finish the first region to win this trophy !";
          break;
        case 'East':
          trophySize = screenHeight * 0.7;
          offsetHeight = 10;
          text1 =
              "we found a map of the east with a red mark on it  ... you know what that means ?";
          text2 = "finish the second region to win this trophy !";
          break;
        case 'West':
          trophySize = screenHeight * 0.65;
          offsetHeight = 15;
          offsetWidth = -7;
          text1 =
              "In a beautiful mountain in the West, far from sight, a great trophy waits for a brave explorer to find it.";
          text2 = "finish the third region to win this trophy !";
          break;
        case 'South':
          trophySize = screenHeight * 0.7;
          offsetHeight = 11;
          text1 =
              "Legend says that when the Fennec King left his treasure, a shiny golden trophy was lost somewhere in the sahara.";
          text2 = "finish the fourth region to win this trophy !";
          break;
        default:
          trophySize = 140;
          offsetHeight = 10;
          break; // Default case if `tmp` doesn't match any of the cases
      }
    } else {
      trophySize = screenHeight * 0.55;
      offsetHeight = 0;

      text1 =
          "this medal is a prove of courage given by the local citizens ... to memorize the bravest explorer !";
      text2 = "finish the adventure of $adventure to win this medal !";
      if (adventure == "Algiers" ||
          adventure == "Constantine" ||
          adventure == "Oran" ||
          adventure == "Tamanrasset") {
        adNb = 1;
      } else {
        adNb = 2;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: trophieContainerWidth,
              height: trophyContainerHeight,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Transform.translate(
                offset: Offset(offsetWidth, offsetHeight),
                child: OverflowBox(
                  maxWidth: trophySize,
                  maxHeight: trophySize,
                  child: Image.asset(
                    (adventure == "")
                        ? userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['completed']
                            ? "assets/icons/trophie_page/trophie$region.png"
                            : "assets/icons/trophie_page/nottrophie$region.png"
                        : userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['adventures']['adventure_$adNb']['completed']
                        ? "assets/icons/trophie_page/medal.png"
                        : "assets/icons/trophie_page/notMedal.png",
                    width: trophySize,
                    height: trophySize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          // description + name
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // region name
              width: regionTextContainerWidth,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  region,
                  style: TextStyle(
                    fontFamily: 'Fredoka3',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56351E),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: discriptionContainerWidth,
              height: discriptionContainerHeight,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Fredoka3',
                      fontSize: screenWidth * 0.0195,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF56351E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    text2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Fredoka3',
                      fontSize: screenWidth * 0.022,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildColumn(String region, String trophie) {
    final userData = Provider.of<DataProvider>(context).userData;
    double containerWidth = 100; // Keep the original width
    double trophySize; // Increased trophy size
    double offsetHeight;
    double offsetWidth = 0;
    String adv1 = "", adv2 = "";
    switch (region) {
      case 'North':
        trophySize = 140;
        offsetHeight = 1;
        adv1 = "Algiers";
        adv2 = "Tipaza";
        break;
      case 'East':
        trophySize = 140;
        offsetHeight = 5;
        adv1 = "Constantine";
        adv2 = "Bejaia";
        break;
      case 'West':
        trophySize = 132;
        offsetHeight = 10;
        offsetWidth = -2;
        adv1 = "Oran";
        adv2 = "tlemcen";
        break;
      case 'South':
        trophySize = 140;
        offsetHeight = 5;
        adv1 = "Tamanrasset";
        adv2 = "Illizi";
        break;
      default:
        trophySize = 140;
        offsetHeight = 10;
        break; // Default case if `tmp` doesn't match any of the cases
    }

    double trophyContainerHeight = 120; // Keep the original height
    double medalSize = 35;
    double medalBoxSize = 45;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Region name inside a white rounded rectangle
        Container(
          width: containerWidth,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              region,
              style: TextStyle(
                fontFamily: 'Fredoka3',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF56351E),
              ),
            ),
          ),
        ),

        SizedBox(height: 5),

        // Trophy wrapped in a white rectangle
        Column(
          children: [
            SizedBox(height: 10), // Moves the container down
            GestureDetector(
              onTap: () => handleTrophyClick(region, ""),
              child: Container(
                width: containerWidth,
                height: trophyContainerHeight,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Transform.translate(
                  offset: Offset(offsetWidth, offsetHeight),
                  child: OverflowBox(
                    maxWidth: trophySize,
                    maxHeight: trophySize,
                    child: Image.asset(
                      userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['completed']
                          ? "assets/icons/trophie_page/$trophie.png"
                          : "assets/icons/trophie_page/not$trophie.png",
                      width: trophySize,
                      height: trophySize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        // Two separate medal containers
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Medal 1 in a smaller white rectangle
            GestureDetector(
              onTap: () => handleTrophyClick(region, adv1),
              child: Container(
                width: medalBoxSize,
                height: medalBoxSize,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['adventures']['adventure_1']['completed']
                      ? "assets/icons/trophie_page/medal.png"
                      : "assets/icons/trophie_page/notMedal.png",
                  width: medalSize,
                  height: medalSize,
                ),
              ),
            ),

            SizedBox(width: 5),

            // Medal 2 in a smaller white rectangle
            GestureDetector(
              onTap: () => handleTrophyClick(region, adv2),

              child: Container(
                width: medalBoxSize,
                height: medalBoxSize,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['adventures']['adventure_2']['completed']
                      ? "assets/icons/trophie_page/medal.png"
                      : "assets/icons/trophie_page/notMedal.png",
                  width: medalSize,
                  height: medalSize,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg6.jpg", fit: BoxFit.fill),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0001,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "TROPHIES",
                    style: TextStyle(
                      fontFamily: 'Fredoka3',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (selectedRegion == "")
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

          Positioned(
            right: screenWidth * 0.075, // Adjust as needed
            top: screenHeight * 0.16, // Adjust vertical position
            child: Container(
              height: screenHeight * 0.677,
              width: screenWidth * 0.68,
              decoration: BoxDecoration(
                color: Color(0xFF53C8C0),
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  selectedRegion == ""
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildColumn("North", "trophieNorth"),
                          buildColumn("East", "trophieEast"),
                          buildColumn("West", "trophieWest"),
                          buildColumn("South", "trophieSouth"),
                        ],
                      )
                      : showInfoTrofie(selectedRegion, selectedAdventure),
            ),
          ),
          if (selectedRegion != "")
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    handleTrophyClick("", "");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF56351E), // Brown background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Fully rounded edges
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 5,
                    ), // Adjust size
                  ),
                  child: Text(
                    "confirm",
                    style: TextStyle(
                      fontFamily: 'Fredoka3', // Use the same font as your app
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            left: screenWidth * 0,
            top: screenHeight * 0.2,
            child: SizedBox(
              height: screenHeight * 0.62,
              width: screenWidth * 0.3,
              child: GestureDetector(
                onTapDown: _onFennecTapDown,
                onTapUp: _onFennecTapUp,
                onTapCancel: _onFennecTapCancel,
                child: AnimatedBuilder(
                  animation: _fennecAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _fennecAnimation.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    "assets/icons/trophie_page/trophie_fennec.png",
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
