import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';


class UserProfile {
  final String firstName;
  final String lastName;
  final String age;
  final int? avatarIndex;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.age,
    this.avatarIndex,
  });

  @override
  String toString() {
    return 'UserProfile(firstName: $firstName, lastName: $lastName, age: $age, avatarIndex: $avatarIndex)';
  }
}

class EditProfilePage extends StatefulWidget {

    final int profileNbr;

    const EditProfilePage({Key? key, required this.profileNbr}) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}


class EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  int? selectedIndex;

  final List<String> avatars = [
    'assets/icons/avatar0_icon.png',
    'assets/icons/avatar1_icon.png',
    'assets/icons/avatar2_icon.png',
    'assets/icons/avatar3_icon.png',
    'assets/icons/avatar4_icon.png',
    'assets/icons/avatar5_icon.png',
    'assets/icons/avatar6_icon.png',
    'assets/icons/avatar7_icon.png',
  ];


  @override
  void initState() {
    super.initState();

    // Pré-remplir les champs avec les informations existantes
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    setState(() {
      _firstNameController.text = userData['Profiles']['Profile_${widget.profileNbr}']['firstName'];
      _lastNameController.text = userData['Profiles']['Profile_${widget.profileNbr}']['lastName'];
      _ageController.text = userData['Profiles']['Profile_${widget.profileNbr}']['age'];
      selectedIndex = int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['avatar']);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void selectImage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  void _showValidationDialog(BuildContext context, String message) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Error",
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          // Blurred Background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          // Dialog Box
          Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                child: Container(
                  width: 320,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/icons/fennec_settings_icon.png", 
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "OUPS, Error!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 20),
                      _buildDialogButton("OK", Colors.redAccent, () => Navigator.of(context).pop()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

Widget _buildDialogButton(String text, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.9),
        boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, offset: Offset(2, 4))],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

void _showValidationDialog2(BuildContext context, String message,UserProfile profile) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Profile created",
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          // Blurred Background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          // Dialog Box
          Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                child: Container(
                  width: 320,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/icons/happy_fennec_icon.png", 
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Yaay, Congrats!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 20),
                      _buildDialogButton("Proceed", Colors.greenAccent, () =>Navigator.pop(context, profile)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/backgrounds/bg3.jpg", fit: BoxFit.fill),

          Positioned(
            top: 20,
            left: 16,
            child: Material(
              borderRadius: BorderRadius.circular(32),
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () => Navigator.of(context).pop(),
                child: Ink.image(
                  image: AssetImage("assets/icons/back_icon.png"),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

         Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.015),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(4, (index) => _buildAvatar(index)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(4, (index) => _buildAvatar(index + 4)),
                  ),
                ],
              ),
            ),
          ),

          _buildTextField(_firstNameController, "First Name", 0.29),
          _buildTextField(_lastNameController, "Last Name", 0.44),
          _buildTextField(_ageController, "Age", 0.59),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "EDIT",  
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                      height: MediaQuery.of(context).size.height > 700 ? 0.9 : 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Material(
                  color: const Color.fromARGB(0, 255, 8, 8),
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String age = _ageController.text;

                      if (firstName.isEmpty || lastName.isEmpty || age.isEmpty) {
                        _showValidationDialog(context, "Please fill in all fields!");
                        return;
                      }

                      if (int.tryParse(age) == null || int.parse(age) < 3 || int.parse(age) > 12) {
                        _showValidationDialog(context, "Age must be a valid number between 3 and 12!");
                        return;
                      }

                      if (firstName.length > 10) {
                        _showValidationDialog(context, "First name must not exceed 10 characters!");
                        return;
                      } 

                      if (selectedIndex == null) {
                        _showValidationDialog(context, "Please select a profile picture!");
                        return;
                      }

                      // Create updated profile
                      UserProfile updatedProfile = UserProfile(
                        firstName: firstName,
                        lastName: lastName,
                        age: age,
                        avatarIndex: selectedIndex,
                      );

                      userData['Profiles']['Profile_${widget.profileNbr}']['created'] = true ;
                      userData['Profiles']['Profile_${widget.profileNbr}']['firstName'] = firstName;  
                      userData['Profiles']['Profile_${widget.profileNbr}']['lastName'] = lastName ;
                      userData['Profiles']['Profile_${widget.profileNbr}']['age'] = age ;
                      userData['Profiles']['Profile_${widget.profileNbr}']['avatar'] = selectedIndex.toString() ;

                    _showValidationDialog2(context, "Your profile has been updated!", updatedProfile);
                      
                    },
                    child: Ink.image(
                      image: AssetImage("assets/icons/confirm_icon.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index) {
  double screenWidth = MediaQuery.of(context).size.width;
  //double screenHeight = MediaQuery.of(context).size.height;
  return GestureDetector(
    onTap: () => selectImage(index),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: screenWidth * 0.1,  
        height: screenWidth * 0.1,
        padding: EdgeInsets.all(selectedIndex == index ? 6 : 3), 
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedIndex == index ? Colors.greenAccent : Colors.transparent,
            width: selectedIndex == index ? 4 : 2, 
          ),
          boxShadow: selectedIndex == index
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: ClipOval(
          child: Image.asset(
            avatars[index],
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

  Widget _buildTextField(TextEditingController controller, String hint, double topPadding) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: EdgeInsets.only(top: screenHeight * topPadding, left: screenWidth * 0.1),
      child: Container(
        width: screenWidth * 0.35,
        height: screenHeight * 0.12,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 232, 232, 232).withOpacity(0.8), 
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Kavivanar',
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Kavivanar',
              fontSize: 16,
              color: Colors.black54,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    ),
  );
}
}
