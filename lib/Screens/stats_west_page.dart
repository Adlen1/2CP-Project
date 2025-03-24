import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/main_page.dart';
import 'package:project_2cp_eq11/Screens/stats_east_page.dart';
import 'package:project_2cp_eq11/Screens/stats_north_page.dart';
import 'package:project_2cp_eq11/Screens/stats_south_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class StatsWest extends StatefulWidget {
  final int profileNbr;

  const StatsWest({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _StatsWestState createState() => _StatsWestState();
}

class _StatsWestState extends State<StatsWest> with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  double progress = 0;
  int unlocked_minigames = 0 ;
  int unlocked_adventures = 0 ;
  int stars_obtained = 0;
  int monuments_unlocked = 0 ;

  @override
  void initState() {
    super.initState();
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_fennecController);
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

    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Search"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Search"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Search"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Search"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Puzzle"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Puzzle"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Puzzle"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Puzzle"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Color"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Color"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Color"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Color"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Play"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Play"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Play"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Play"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Memory"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Memory"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Memory"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Memory"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Spot"][0] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Spot"][1] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Spot"][2] &&
       userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["Spot"][3]
    ) {
      unlocked_minigames ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['Regions']["region_west"]["adventures"]["adventure_1"]["completed"]) {
      unlocked_adventures ++ ;
    }

    if(userData['Profiles']['Profile_${widget.profileNbr}']['Regions']["region_west"]["adventures"]["adventure_2"]["completed"]) {
      unlocked_adventures ++ ;
    }

    stars_obtained = userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SearchStar"][0] + 
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SearchStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SearchStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SearchStar"][3] + 
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PuzzleStar"][0] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PuzzleStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PuzzleStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PuzzleStar"][3] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["ColorStar"][0] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["ColorStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["ColorStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["ColorStar"][3] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PlayStar"][0] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PlayStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PlayStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["PlayStar"][3] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["MemoryStar"][0] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["MemoryStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["MemoryStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["MemoryStar"][3] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SpotStar"][0] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SpotStar"][1] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SpotStar"][2] +
                     userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["SpotStar"][3] ;

    progress = 0.5 * (stars_obtained / 18.0) 
             + 0.2 * (monuments_unlocked / 6.0) 
             + 0.2 * (unlocked_minigames / 6.0) 
             + 0.1 * (unlocked_adventures / 2.0);
    int progressPercentage = (progress * 100).round();


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                        Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(profileNbr: widget.profileNbr,),
                      ),
                    );
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
                  "assets/icons/stats_fennec_icon.png",
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

          AnimatedGameButton("assets/icons/light_red_button_icon.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.28, screenHeight * 0.17,"North" ,destination: StatsNorth(profileNbr:widget.profileNbr),),
          AnimatedGameButton("assets/icons/light_red_button_icon.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.435, screenHeight * 0.17," East" ,destination: StatsEast(profileNbr:widget.profileNbr),),
          AnimatedGameButton("assets/icons/light_red_button_icon.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.745, screenHeight * 0.17,"South" ,destination: StatsSouth(profileNbr:widget.profileNbr),),

          


          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height * 0.05), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.7, 
              height: MediaQuery.of(context).size.height * 0.5, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color(0xFFE4083F), 
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

          AnimatedGameButton("assets/icons/red_button_icon.png", screenWidth * 0.18, screenHeight * 0.18, screenWidth * 0.59 , screenHeight * 0.17,"West"),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.048,- MediaQuery.of(context).size.height * 0.1), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.555, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.38,- MediaQuery.of(context).size.height * 0.1), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.09, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.76 , top: MediaQuery.of(context).size.height * 0.36), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "$progressPercentage%",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.38, MediaQuery.of(context).size.height * 0.05), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.09, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.76 , top: MediaQuery.of(context).size.height * 0.51), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "$stars_obtained/18",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.38, MediaQuery.of(context).size.height * 0.2), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.09, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.76 , top: MediaQuery.of(context).size.height * 0.66), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "$unlocked_minigames/6",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.045, MediaQuery.of(context).size.height * 0.05), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.09, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
                borderRadius: BorderRadius.circular(20), 
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1), 
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09 , top: MediaQuery.of(context).size.height * 0.51), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "0/6",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.045, MediaQuery.of(context).size.height * 0.2), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.09, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09 , top: MediaQuery.of(context).size.height * 0.66), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "$unlocked_adventures/2",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.215, MediaQuery.of(context).size.height * 0.05), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.22, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.42 , top: MediaQuery.of(context).size.height * 0.51), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "Stars",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.215, MediaQuery.of(context).size.height * 0.2), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.22, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.42 , top: MediaQuery.of(context).size.height * 0.66), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "Monuments",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(- MediaQuery.of(context).size.width * 0.12, MediaQuery.of(context).size.height * 0.05), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.22, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.315 , top: MediaQuery.of(context).size.height * 0.51), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "Mini games",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(- MediaQuery.of(context).size.width * 0.12, MediaQuery.of(context).size.height * 0.2), 
              child: Container(
              width: MediaQuery.of(context).size.width * 0.22, 
              height: MediaQuery.of(context).size.height * 0.115, 
              padding: EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), 
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

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.315 , top: MediaQuery.of(context).size.height * 0.66), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "Adventures",  
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.35, 
            left: screenWidth * 0.276,  
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: screenWidth * 0.545,
                height: screenHeight * 0.1,
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
  final String iconPath;
  final double width;
  final double height;
  final double left;
  final double top;
  final String text;
  final Widget? destination; 

  AnimatedGameButton(this.iconPath, this.width, this.height, this.left, this.top,this.text, {this.destination});

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
      lowerBound: 0.75,
      upperBound: 1.2,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());

    // If a destination is provided, navigate to it
    if (widget.destination != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => widget.destination!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: _onTap,
        child: Stack(
          alignment: Alignment.center, // Centers the text on the image
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                widget.iconPath,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: widget.width * 0.32,  // Adjust left positioning as needed
              top: widget.height * 0.3,  // Adjust top positioning as needed
              child: Text(
                widget.text, // Replace with dynamic text if needed
                style: TextStyle(
                  fontSize: widget.width * 0.13,  // Adjust font size
                  fontFamily: "Fredoka2",
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

