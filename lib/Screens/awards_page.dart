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

  Widget buildColumn(String region, String trophie) {
    final userData = Provider.of<DataProvider>(context).userData;
    double containerWidth = 100; // Keep the original width
    double trophySize; // Increased trophy size
    double offsetHeight;
    double offsetWidth = 0;

    switch (region) {
      case 'North':
        trophySize = 140;
        offsetHeight = 1;
        break;
      case 'East':
        trophySize = 140;
        offsetHeight = 5;
        break;
      case 'West':
        trophySize = 132;
        offsetHeight = 10;
        offsetWidth = -2;
        break;
      case 'South':
        trophySize = 140;
        offsetHeight = 5;
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
                fontFamily: 'Fredoka',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
        ),

        SizedBox(height: 12),

        // Trophy wrapped in a white rectangle
        Column(
          children: [
            SizedBox(height: 10), // Moves the container down
            Container(
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
                offset: Offset(
                  offsetWidth,
                  offsetHeight,
                ), // Move down by 20 pixels
                child: OverflowBox(
                  maxWidth: trophySize,
                  maxHeight: trophySize,
                  child: Image.asset(
                    userData['Profiles']['Profile_${widget.profileNbr}']['Regions']['region_${region.toLowerCase()}']['completed'] ==
                            false
                        ? "assets/icons/trophie_page/$trophie.png"
                        : "assets/icons/trophie_page/not$trophie.png",
                    width: trophySize,
                    height: trophySize,
                    fit: BoxFit.contain,
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
            Container(
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

            SizedBox(width: 5),

            // Medal 2 in a smaller white rectangle
            Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildColumn("North", "trophieNorth"),
                  buildColumn("East", "trophieEast"),
                  buildColumn("West", "trophieWest"),
                  buildColumn("South", "trophieSouth"),
                ],
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
