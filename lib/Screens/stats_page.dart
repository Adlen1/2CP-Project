import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class StatsPage extends StatefulWidget {
  final int profileNbr;

  const StatsPage({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;

  double progress = 0;
  int unlocked_minigames = 0 ;
  int unlocked_adventures = 0 ;
  num stars_obtained = 0;
  int monuments_unlocked = 0 ;

  String selectedRegion = "North";

  final Color selectedColor = Color(0xFFE4083F);
  final Color unselectedColor = Color(0xFFFE6D73);

   void selectRegion(String region) {
    List<String> minigameTypes = ["Search", "Puzzle", "Color", "Play", "Memory", "Spot"];
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    setState(() {
      
      unlocked_minigames = 0 ;
      unlocked_adventures = 0 ;
      stars_obtained = 0;
       monuments_unlocked = 0 ;
      selectedRegion = region;

      Map<String, int> regionIndex = {
        "North": 0,
        "East": 1,
        "South": 3,
        "West": 2
      };

      int i = regionIndex[selectedRegion]!;

      for (var type in minigameTypes) {
        if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames'][type][i]) {
          unlocked_minigames++;
        }     
        stars_obtained += userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${type}Star"][i];
      }


    if (userData['Profiles']['Profile_${widget.profileNbr}']['Regions']["region_${selectedRegion.toLowerCase()}"]["adventures"]["adventure_1"]["completed"]) {
      unlocked_adventures++;
    }

    if (userData['Profiles']['Profile_${widget.profileNbr}']['Regions']["region_${selectedRegion.toLowerCase()}"]["adventures"]["adventure_2"]["completed"]) {
      unlocked_adventures++;
    }

    progress = 0.5 * (stars_obtained / 18.0) 
             + 0.2 * (monuments_unlocked / 6.0) 
             + 0.2 * (unlocked_minigames / 6.0) 
             + 0.1 * (unlocked_adventures / 2.0);
    
    });
  }


  @override
  void initState() {
    super.initState();

    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_fennecController);
    
    selectRegion("North");

  }

  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
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
    int progressPercentage = (progress * 100).round();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/bg7.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // Back Button (Top Left)
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

          Positioned(
            left:- screenWidth * 0.22, 
            top: screenHeight * 0.12, 
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
                  "assets/icons/fennec/stats_fennec_icon.png",
                  height: screenHeight * 0.75,
                  width: screenWidth * 0.75,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.001), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "STATS",  
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

          // Unselected Buttons
          Stack(
            children: [
              if (selectedRegion != "North")
                AnimatedGameButton(
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.15,
                  left: screenWidth * 0.28,
                  top: screenHeight * 0.19,
                  text: "North",
                  color: unselectedColor,
                  onTap: () => selectRegion("North"),
                ),
              if (selectedRegion != "East")
                AnimatedGameButton(
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.15,
                  left: screenWidth * 0.435,
                  top: screenHeight * 0.19,
                  text: "East",
                  color: unselectedColor,
                  onTap: () => selectRegion("East"),
                ),
              if (selectedRegion != "West")
                AnimatedGameButton(
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.15,
                  left: screenWidth * 0.59,
                  top: screenHeight * 0.19,
                  text: "West",
                  color: unselectedColor,
                  onTap: () => selectRegion("West"),
                ),
              if (selectedRegion != "South")
                AnimatedGameButton(
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.15,
                  left: screenWidth * 0.745,
                  top: screenHeight * 0.19,
                  text: "South",
                  color: unselectedColor,
                  onTap: () => selectRegion("South"),
                ),
            ],
          ),

          // Center Info Box 
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(screenWidth * 0.1, screenHeight * 0.05),
              child: Container(
                width: screenWidth * 0.7,
                height: screenHeight * 0.5,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Selected Button (Always on Top)
          AnimatedGameButton(
            width: screenWidth * 0.16,
            height: screenHeight * 0.15,
            left: {
              "North": screenWidth * 0.28,
              "East": screenWidth * 0.435,
              "West": screenWidth * 0.59,
              "South": screenWidth * 0.745,
            }[selectedRegion]!,
            top: screenHeight * 0.19,
            text: selectedRegion,
            color: selectedColor,
            onTap: () => selectRegion(selectedRegion),
          ),
          
          InfoBox(width: screenWidth* 0.555 , height: screenHeight * 0.115, top: screenHeight* 0.34, left: screenWidth* 0.27),
          InfoBox(width: screenWidth* 0.09 , height: screenHeight * 0.115, top: screenHeight* 0.34, left: screenWidth* 0.835,text: "$progressPercentage%",),
          InfoBox(width: screenWidth* 0.09 , height: screenHeight * 0.115, top: screenHeight* 0.495, left: screenWidth* 0.835,text: "$stars_obtained/18",),
          InfoBox(width: screenWidth* 0.09 , height: screenHeight * 0.115, top: screenHeight* 0.645, left: screenWidth* 0.835,text: "$monuments_unlocked/6",),
          InfoBox(width: screenWidth* 0.09 , height: screenHeight * 0.115, top: screenHeight* 0.495, left: screenWidth* 0.5,text: "$unlocked_minigames/6",),
          InfoBox(width: screenWidth* 0.09 , height: screenHeight * 0.115, top: screenHeight* 0.645, left: screenWidth* 0.5,text: "$unlocked_adventures/2",),
          InfoBox(width: screenWidth* 0.22 , height: screenHeight * 0.115, top: screenHeight* 0.495, left: screenWidth* 0.27,text: "Mini games",),
          InfoBox(width: screenWidth* 0.22 , height: screenHeight * 0.115, top: screenHeight* 0.645, left: screenWidth* 0.27,text: "Adventures",),
          InfoBox(width: screenWidth* 0.22 , height: screenHeight * 0.115, top: screenHeight* 0.495, left: screenWidth* 0.6,text: "Stars"),
          InfoBox(width: screenWidth* 0.22 , height: screenHeight * 0.115, top: screenHeight* 0.645, left: screenWidth* 0.6,text: "Monuments",),

          Positioned(
            top: screenHeight * 0.349, 
            left: screenWidth * 0.275,  
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: screenWidth * 0.545,
                height: screenHeight * 0.096,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFE6D73)),
                  minHeight: screenHeight * 0.06,
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}

class AnimatedGameButton extends StatefulWidget {
  final double width;
  final double height;
  final double left;
  final double top;
  final String text;
  final Color color;
  final VoidCallback onTap;


  const AnimatedGameButton({
    Key? key,
    required this.width,
    required this.height,
    required this.left,
    required this.top,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedGameButtonState createState() => _AnimatedGameButtonState();
}

class _AnimatedGameButtonState extends State<AnimatedGameButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.85,
      upperBound: 1.1,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: _onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            children: [
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                left: widget.width * 0.3,  // Adjust text position
                top: widget.height * 0.15,  
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontFamily: "Fredoka2",
                    color: Color(0xFF56351E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final double width;
  final double height;
  final double top;
  final double left;
  final String? text;

  const InfoBox({
    Key? key,
    required this.width,
    required this.height,
    required this.top,
    required this.left,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: height,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Move text upwards
          crossAxisAlignment: CrossAxisAlignment.center, // Keep it centered
          children: [
            if (text != null)
              Padding(
                padding: EdgeInsets.only(top: height * 0.16), // Adjust how far from the top
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka2',
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56351E),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
