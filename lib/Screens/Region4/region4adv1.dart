import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class Region4Adv1 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region4Adv1({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region4Adv1State createState() => _Region4Adv1State();
}

class _Region4Adv1State extends State<Region4Adv1>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 1);
    int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) > 6
        ? GameLogic.setRegion(context, widget.profileNbr, 3)
        : GameLogic.setRegion(context, widget.profileNbr, 4);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    int userAge =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;
    bool old = (userAge > 6);

    void proceedToNextDialogue({
      required BuildContext context,
      required List<Map<String, String>> dialogues,
      required int currentDialogueIndex,
      required Function onDialogueEnd,
      required Function startTyping,
      required bool isTyping,
      required String displayedText,
      required Function completeText,
      required Function updateDialogueIndex,
      required Future<void> Function(String) pauseView,
      required Function stopAudio,
    }) {
      stopAudio();

      if (isTyping) {
        completeText();
      } else {
        switch (currentDialogueIndex) {
          case var i when i == dialogues.length - 1:
            onDialogueEnd.call();
            return;

          case 7:
            {
              updateDialogueIndex();
              pauseView("Assekrem Plateau").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][0] =
                  true;
              break;
            }

          case 11:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region4/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region4/adventure1/repair-tools.png",
                          "assets/icons/region4/adventure1/pen.png",
                          "assets/icons/region4/adventure1/paint-brush.png",
                          "assets/icons/region4/adventure1/mallet.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick the sculpting tool",
                        correctIndexes: [3],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 17:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 3,
                        levelNb: 4,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 18:
            {
              updateDialogueIndex;
              pauseView("Sahara drawings").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][1] =
                  true;

              break;
            }
          case 28:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region4/adventure1/bg3.jpg",
                        items: [
                          "assets/icons/region4/adventure1/bench.png",
                          "assets/icons/region4/adventure1/umbrella.png",
                          "assets/icons/region4/adventure1/ball.png",
                          "assets/icons/region4/adventure1/cup.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "take a seat !!",
                        correctIndexes: [0],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 31:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 5,
                        levelNb: 4,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 32:
            {
              updateDialogueIndex();
              pauseView("The Sahara").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][2] =
                  true;
              break;
            }
          case 41:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region4/adventure1/bg4.jpg",
                        items: [
                          "assets/icons/region4/adventure1/map.png",
                          "assets/icons/region4/adventure1/bag.png",
                          "assets/icons/region4/adventure1/compass.png",
                          "assets/icons/region4/adventure1/bottle.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick what do you need !!",
                        correctIndexes: [0, 1, 2, 3],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });

              break;
            }
          case 45:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 4,
                        levelNb: 4,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          default:
            updateDialogueIndex();
            startTyping();
        }
      }
    }

    void proceedToPreviousDialogue({
      required BuildContext context,
      required List<Map<String, String>> dialogues,
      required int currentDialogueIndex,
      required Function onDialogueEnd,
      required Function startTyping,
      required bool isTyping,
      required String displayedText,
      required Function completeText,
      required Function updateDialogueIndex,
      required Function pauseView,
      required Function stopAudio,
    }) {
      stopAudio();

      if (isTyping) {
        completeText();
      } else {
        switch (currentDialogueIndex) {
          case -1:
            {
              Navigator.pop(context);
            }

          case 8:
            {
              pauseView("Assekrem Plateau");
              break;
            }
          case 19:
            {
              pauseView("Sahara drawings");
              break;
            }
          case 33:
            {
              pauseView("The Sahara");
              break;
            }
          default:
            updateDialogueIndex();
        }
      }
    }

    void skipDialogue({
      required BuildContext context,
      required List<Map<String, String>> dialogues,
      required int currentDialogueIndex,
      required Function onDialogueEnd,
      required Function startTyping,
      required bool isTyping,
      required String displayedText,
      required Function completeText,
      required Function updateDialogueIndex,
    }) {
      // Define skip indexes
      List<int> targetIndexes = [17, 31, 45];

      // If text is typing, complete it
      if (isTyping) {
        completeText();
      } else {
        // Sort indexes to make sure they’re in order
        targetIndexes.sort();

        // Find the next target index
        int? nextTargetIndex;
        for (int target in targetIndexes) {
          if (currentDialogueIndex < target) {
            nextTargetIndex = target;
            break;
          }
        }

        if (nextTargetIndex != null && nextTargetIndex < dialogues.length) {
          updateDialogueIndex(nextTargetIndex);
        } else {
          // If no more targets, finish or go to next dialogue
          if (currentDialogueIndex >= dialogues.length - 1) {
            onDialogueEnd();
          } else {
            updateDialogueIndex(currentDialogueIndex + 1);
          }
        }
      }
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          DialogueBox(
            proceedToPreviousDialogue: proceedToPreviousDialogue,
            proceedToNextDialogue: proceedToNextDialogue,
            skipDialogue: skipDialogue,
            lockview: lockview,
            profileNbr: widget.profileNbr,
            region: widget.region,
            adventure: widget.adventure,
            initIndex: widget.initIndex,
            dialogues: [
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    "What a beautiful day here in the Sahara,Oh Ace great to see you !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/1.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    "Oh Maria my cousin  !! I finally came home. The desert of Tamenrasset.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/2.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    "You should tell me after about the magnificent stories and the memories with your friend",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/3.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text": "Sure,Now you’re going to present the region to us.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/4.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    "Sure,you know that i’m passionated about our region more than You.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/5.mp3",
              },
              {
                //number 5
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text": "Lets Go.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/6.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    "Whoa! Look at those giant red rocks! Are they castles? Or maybe... giant sand cakes?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/7.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg1.jpg",
                "text":
                    old
                        ? "Haha, not quite, Ace! These are real rock formations called Assekrem Plateau found in the Sahara desert in Hoggar mountain . "
                        : "Haha, not quite, Ace! These are real rock formations called the Assekrem Plateau, located in the Hoggar Mountains.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice":
                    old
                        ? "audios/region4/adventure1/8.mp3"
                        : "audios/region4/adventure1/88.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "They've been shaped by wind and time over thousands of years!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/9.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "So the wind is like a secret sculptor? That’s amazing! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/10.mp3",
              },
              {
                //number 10
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "As we talked about sculptors , do you know what do they use ? ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/11.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "Uum , I am not sure but mu friend will definitely pick a sculpting tool !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/12.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "Whoa nice my friend!! Tell me Maria did people live there too?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/13.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "Great question! Yes! Long ago, people lived nearby and even painted on the rocks!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/14.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    old
                        ? "You can still find ancient drawings that show animals, hunters, and daily life from thousands of years ago."
                        : "You can still see old drawings of animals, hunters, and daily life from thousands of years ago.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice":
                    old
                        ? "audios/region4/adventure1/15.mp3"
                        : "audios/region4/adventure1/1515.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text": "I wanna see those drawings! Can we go?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/16.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "Sure, We can but I want to test you before, see these giant rocks I wanna hide some things you must find them, ready Go!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/17.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text": "YAY! Let’s find the objects little explorer!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/18.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg2.jpg",
                "text":
                    "Well done, You told me that you wanna see the drawings, let’s GO!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/19.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Are those cows? And long-legged creatures? Did they have a zoo in the desert?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/20.mp3",
              },
              {
                //number 20
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Not a zoo, Ace! Those are animals that lived here a long time ago.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/21.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "People painted them on these rocks to remember their lives and adventures.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/22.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text": "So it’s like a giant book... made of STONE?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/23.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    old
                        ? "Exactly! This place is one of the biggest open-air museums in the world! It's full of drawings that are over 8,000 years old!"
                        : "Exactly! This place is full of drawings that are more than 8,000 years old!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice":
                    old
                        ? "audios/region4/adventure1/24.mp3"
                        : "audios/region4/adventure1/2424.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Eight thousand?! That’s older than my grand-grand-fox!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/25.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "That’s right! And guess what? These drawings are called rock art or cave paintings.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/26.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "They show animals like cows, giraffes, and even people dancing or hunting.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/27.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "It's how ancient people shared their stories—before books even existed.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/28.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Stories without words? That’s so cool! Now let’s rest a bit before continuing the journey!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/29.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Woah great young explorer!! Maria can we play with them?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/30.mp3",
              },
              {
                //number 30
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text":
                    "Sure, you can construct your own ancient drawing with puzzel",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/31.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text": "That would be magnificent!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/32.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg3.jpg",
                "text": "Our Adventure isn’t finished yet.\nTo the Sahara!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/33.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Wooow... it’s HUGE here! All this sand and giant rocks… are we on another planet?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/34.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Not another planet, little explorer! Welcome to the Sahara the Algerian Desert—the largest hot desert in the world!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/35.mp3",
              },
              {
                //35
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    old
                        ? "It’s full of golden dunes, wide rocky plains… and these big tall rocks shaped by the wind over millions of years!"
                        : "It’s full of golden dunes, wide rocky plains, and huge tall rocks formed by the wind since a long time ago!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice":
                    old
                        ? "audios/region4/adventure1/36.mp3"
                        : "audios/region4/adventure1/3636.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "So it’s like a giant playground for the wind?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/37.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Exactly! The wind is like an artist here. It carves the rocks and moves the sand.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/38.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "I see that this takes time!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/39.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    old
                        ? "Yes, it would take a lot to see this view, this is the home of different animals that can handle all the difficulties of the Desert."
                        : "Yes, it takes a lot to reach this view. This is home to animals that can survive in the desert.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice":
                    old
                        ? "audios/region4/adventure1/40.mp3"
                        : "audios/region4/adventure1/4040.mp3",
              },
              {
                // number 40
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "HAHA like the camel!!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/41.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Exactly! Now little explorer before we continue, you must build your desert survival kit. Pick what do you need!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/42.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Nice! Now do you want to sum up all what you have seen.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/43.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "Oh,yes but…this will end our adventure?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/44.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "In TAMENRASSET, yes but not in the region.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/45.mp3",
              },
              {
                //45
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "NICE! Let’s finish this.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/46.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "You know… I’m from the south, but I didn’t know all these amazing secrets.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/47.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Thanks, Maria… for showing me my own desert like it’s the first time!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/48.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text":
                    "Your welcome, Come with your friend any time to Tamenrasset.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/49.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "But the journey isn’t finished let’s head to Illizi!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure1/50.mp3",
              },
              {
                //number 50
                "bg": "assets/backgrounds/region4/adventure1/bg4.jpg",
                "text": "YAYY!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure1/51.mp3",
              },
            ],
            onDialogueEnd: () {
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["completed"] =
                  true;
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Back Button with Confirmation Dialog
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        ValidationDialog.show(
                          context: context,
                          title: "Back ?",
                          message: "Are you sure you want to go back?",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Go back
                                Navigator.pop(context);
                              },
                            ),
                            DialogButtonData(
                              text: "No",
                              color: Colors.greenAccent,
                              onTap:
                                  () => Navigator.pop(
                                    context,
                                  ), // Just close dialog
                            ),
                          ],
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
                  SizedBox(width: screenWidth * 0.01), // Spacing
                  // Question Button
                  /*Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {},
                      child: Ink.image(
                        image: AssetImage("assets/icons/question_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // Spacing*/
                  // Pause Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        // Show the PauseDialog
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNbr,
                            ); // This will display the PauseDialog
                          },
                        );
                      },

                      child: Ink.image(
                        image: AssetImage("assets/icons/pause_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // Spacing
                  // View/Unview Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        setState(() {
                          lockview = !lockview; // Toggle the view state
                        });
                      },
                      child: Ink.image(
                        image: AssetImage(
                          lockview
                              ? "assets/icons/unview_icon.png"
                              : "assets/icons/view_icon.png",
                        ),
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
        ],
      ),
    );
  }
}
