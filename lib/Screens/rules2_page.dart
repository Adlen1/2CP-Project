import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/main_page.dart';
import 'package:project_2cp_eq11/Screens/rules3_page.dart';


class Rules2Page extends StatefulWidget {
  final int profileNbr;
  const Rules2Page({Key? key, required this.profileNbr}) : super(key: key);
  @override
  _Rules2PageState createState() => _Rules2PageState();
}

class _Rules2PageState extends State<Rules2Page> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(profileNbr: widget.profileNbr,)));
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
            alignment: Alignment.center, 
            child: Transform.translate(
              offset: Offset(0, - MediaQuery.of(context).size.height*0.05), 
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5, 
                height: MediaQuery.of(context).size.height * 0.5, 
                padding: EdgeInsets.all(20), 
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1), 
                  borderRadius: BorderRadius.circular(24), 
                  border: Border.all(
                    color: Color(0xFFFFCB7C), 
                    width: 5, 
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), 
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: [
                    Text(
                      "2 - you need three correct answers to pass the quiz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        fontFamily: "Fredoka", 
                        color: Color(0xFF56351E),
                      ),
                    ),
                    SizedBox(height: 10), 
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "RULES",  
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // **Yes & No Buttons 
          Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35 , right:MediaQuery.of(context).size.width * 0.001 ), 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        
        ElevatedButton(
          onPressed: (){Navigator.of(context).pop();},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07, 
              vertical: MediaQuery.of(context).size.height * 0.02, 
            ), 
            textStyle: TextStyle(fontSize: 18,fontFamily: "Fredoka",fontWeight: FontWeight.bold),
            backgroundColor: Color(0xFFFE6D73), 
            foregroundColor: Color(0xFF56351E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), 
            ),
          ),
          child: Text("back"),
        ),

        SizedBox(width: MediaQuery.of(context).size.width * 0.05), 

        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Rules3Page(profileNbr: widget.profileNbr,)));
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07, 
              vertical: MediaQuery.of(context).size.height * 0.02, 
            ),
            textStyle: TextStyle(fontSize: 18,fontFamily: "Fredoka" ,fontWeight: FontWeight.bold),
            backgroundColor: Color(0xFF53C8C1), 
            foregroundColor: Color(0xFF56351E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text("Next"),
        ),
      ],
    ),
  ),
)

        ],
      ),
    );
  }
}
