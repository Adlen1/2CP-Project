import 'package:flutter/material.dart';

var new_profile = "assets/backgrounds/new_profile.jpg";
var back = "assets/icons/back_icon.png";
var confirm = "assets/icons/confirm_icon.png";

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

class UserInfoForm extends StatefulWidget {
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
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

  void selectImage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _confirm() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String age = _ageController.text;
    
    UserProfile profile = UserProfile(
      firstName: firstName,
      lastName: lastName,
      age: age,
      avatarIndex: selectedIndex,
    );

    print('User Profile: $profile');
    // TODO: Save the profile data to storage or send it to a backend
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(new_profile, fit: BoxFit.cover),
          Positioned(
            top: 20,
            left: 16,
            child: Material(
              borderRadius: BorderRadius.circular(32),
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () => Navigator.of(context).pop(),
                child: Ink.image(
                  image: AssetImage(back),
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
              padding: const EdgeInsets.only(right: 30.0),
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
          _buildTextField(_firstNameController, "First Name", 120),
          _buildTextField(_lastNameController, "Last Name", 180),
          _buildTextField(_ageController, "Age", 240),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: 264,
                height: 39,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: _confirm,
                    child: Ink.image(
                      image: AssetImage(confirm),
                      fit: BoxFit.cover,
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
    return GestureDetector(
      onTap: () => selectImage(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selectedIndex == index ? const Color.fromARGB(255, 68, 255, 0) : Colors.transparent,
              width: 3,
            ),
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
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, left: 70),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 215, 212, 212).withOpacity(0.8),
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
                color: const Color.fromARGB(255, 90, 90, 90),
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
