import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/Screens/Region2/selectWhateverFrom5.dart';
import 'package:project_2cp_eq11/Screens/Region3/stars.dart';
import 'package:project_2cp_eq11/Screens/quiz_rules_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/Screens/Region3/pickAll.dart';

class Region3Adv1 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region3Adv1({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region3Adv1State createState() => _Region3Adv1State();
}

class _Region3Adv1State extends State<Region3Adv1>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 1);
    int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) > 6
        ? GameLogic.setRegion(context, widget.profileNbr, 2)
        : GameLogic.setRegion(context, widget.profileNbr, 3);
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

          case 8:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure1/bg1.jpg",
                        items: [
                          "assets/icons/region3/adventure1/telescope.png",
                          "assets/icons/region3/adventure1/glasses.png",
                          "assets/icons/region3/adventure1/lens.png",
                          "assets/icons/region3/adventure1/binoculars.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick the telescope ",
                        correctIndexes: [0],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                pauseView("Santa Cruz Chapel").then((_) {
                  startTyping();
                });
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][0] =
                    true;
              });
              break;
            }
          case 18:
            {
              updateDialogueIndex();
              pauseView("Sacred Heart Chapel").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][1] =
                  true;
              break;
            }
          case 25:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => Stars(
                        bg: "assets/backgrounds/region3/adventure1/bg3.jpg",
                        profileNb: widget.profileNbr,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 33:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg3.jpg",
                        items: [
                          "assets/icons/region3/adventure1/Blouza.png",
                          "assets/icons/region3/adventure1/Guandora.png",
                          "assets/icons/region3/adventure1/Chechia.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Blouza", "Guandora", "Chechia"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  updateDialogueIndex();
                  startTyping();
                } else if (result == -1) {
                  startTyping();
                }
              });
              break;
            }

          case 35:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 1,
                        levelNb: 3,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 38:
            {
              updateDialogueIndex();
              pauseView("Arzew lighthouse").then((_) {
                startTyping();
              });
              break;
            }

          case 46:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure1/bg4.jpg",
                        items: [
                          "assets/icons/region3/adventure1/plain.png",
                          "assets/icons/region3/adventure1/car.png",
                          "assets/icons/region3/adventure1/boat.png",
                          "assets/icons/region3/adventure1/train.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Take the boat",
                        correctIndexes: [2],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });

              break;
            }
          case 53:
            {
              updateDialogueIndex();
              pauseView("The Bey palace").then((_) {
                startTyping();
              });

              break;
            }
          case 63:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 4,
                        levelNb: 3,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 69:
            {
              updateDialogueIndex();
              pauseView("The Ben Badis Mosque").then((_) {
                startTyping();
              });
              break;
            }
          case 79:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: [
                          "assets/icons/region3/adventure1/books.png",
                          "assets/icons/region3/adventure1/ball.png",
                          "assets/icons/region3/adventure1/food.png",
                          "assets/icons/region3/adventure1/phone.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Grab the food !",
                        correctIndexes: [2],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 82:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: ["assets/icons/region3/adventure1/seffa.png"],
                        imgWidth: 0.185,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Seffa"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  updateDialogueIndex();
                  startTyping();
                } else if (result == -1) {
                  startTyping();
                }
              });
              break;
            }
          case 84:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PickAll(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: [
                          "assets/icons/region3/adventure1/almond.png",
                          "assets/icons/region3/adventure1/cinammon.png",
                          "assets/icons/region3/adventure1/raisins.png",

                          "assets/icons/region3/adventure1/sugar.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "pick up your ingredients!",
                        correctIndexes: [0, 1, 2, 3],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 88:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: [
                          "assets/icons/region3/adventure1/kalbElLouz.png",
                          "assets/icons/region3/adventure1/harira.png",
                        ],
                        imgWidth: 0.185,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Kalb Louz", "Hrira"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  updateDialogueIndex();
                  startTyping();
                } else if (result == -1) {
                  startTyping();
                }
              });
              break;
            }
          case 90:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 6,
                        levelNb: 3,
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
          case 9:
            {
              pauseView("Santa Cruz Chapel");
              break;
            }
          case 19:
            {
              pauseView("Sacred Heart Chapel");
              break;
            }
          case 34:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg3.jpg",
                        items: [
                          "assets/icons/region3/adventure1/Blouza.png",
                          "assets/icons/region3/adventure1/Guandora.png",
                          "assets/icons/region3/adventure1/Chechia.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Blouza", "Guandora", "Chechia"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping();
                } else if (result == -1) {
                  updateDialogueIndex();
                  startTyping();
                }
              });
              break;
            }
          case 39:
            {
              pauseView("Arzew lighthouse");
              break;
            }
          case 54:
            {
              pauseView("The Bey palace");
              break;
            }
          case 70:
            {
              pauseView("The Ben Badis Mosque");
              break;
            }
          case 83:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: ["assets/icons/region3/adventure1/seffa.png"],
                        imgWidth: 0.185,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Seffa"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping();
                } else if (result == -1) {
                  updateDialogueIndex();
                  startTyping();
                }
              });
              break;
            }
          case 89:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region3/adventure1/bg6.jpg",
                        items: [
                          "assets/icons/region3/adventure1/kalbElLouz.png",
                          "assets/icons/region3/adventure1/harira.png",
                        ],
                        imgWidth: 0.185,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region3/adventure1/Omar.png",
                        text: ["Kalb Louz", "Hrira"],
                        textWidth: 0.16,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping();
                } else if (result == -1) {
                  updateDialogueIndex();
                  startTyping();
                }
              });
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
      List<int> targetIndexes = [35, 63, 90];

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
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text": "Hi Omar, It’s been a while since our last meeting.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/1.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text": "OW ACE, I’m happy to see you again.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/2.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    "I am really excited to explore the western region  with you !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/3.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    "You are going to enjoy the trip!!\nStarting  with exploring Oran, “The city of radiance”.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/4.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    userAge > 6
                        ? "It is a beautiful city by the Mediterannean Sea, rich in history, culture and breathtaking views!! "
                        : "It’s a beautiful city by the sea, full of history, culture, and amazing views!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/5.mp3"
                        : "audios/region3/adventure1/001.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    userAge > 6
                        ? "From its sunny beaches to its historic landmarks, every corner holds memories and secrets, let’s uncover them together!! "
                        : "From sunny beaches to old castles, every place has a story let’s explore them together!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/6.mp3"
                        : "audios/region3/adventure1/002.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    "I can’t wait to explore this wonder with you, my friend!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/7.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    " First let’s get high to The Santa Cruz Chapel. It’s the perfect place to start our unforgettable adventure.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/8.mp3",
              },
              {
                //number 8
                "bg": "assets/backgrounds/region3/adventure1/bg1.jpg",
                "text":
                    "Do you want to see stars?? Pick the telescope, you will need it after young explorer!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/9.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Woah it’s an amazing spot, Oran must be a beautiful place with all those hills giving such an incridible views on the sea!"
                        : "Wow, what a great place! Oran looks so beautiful, with big hills and amazing views of the sea!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/10.mp3"
                        : "audios/region3/adventure1/003.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "Yes exactly, Oran is a coastal town built on hills so you get some awesome sights of the sea.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/11.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "And about the chapel on the screen, It is an old castle high on a mountain, built by the Spanish in 1600.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/12.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "This fort has a lot of history because of the battles that took place there.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/13.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text": "That’s interesting and what about the chapel?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/14.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "The Chapel is called the Virgin Chapel. It has a shiny white dome, and it was built in the 1800s ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/15.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "The aim was to protect people from a terrible disease called cholera",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/16.mp3",
              },
              {
                // number 16
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text":
                    "Later on, a basilica was added to the chapel because many Christians came to visit and pray.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/17.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text": "It’s really a beautiful and meaningful place!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/18.mp3",
              },

              {
                //number18
                "bg": "assets/backgrounds/region3/adventure1/bg2.jpg",
                "text": "Now, let’s talk about The Sacred Heart Cathedral !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/19.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "It’s the second most big church in Oran, and it was first built by the Spanish.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/20.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "The cathedral has a very cool design with three big domes on top and a huge organ that makes beautiful music."
                        : "The cathedral has three big domes and a giant organ that plays beautiful music.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/21.mp3"
                        : "audios/region3/adventure1/004.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "The outside has tall towers and colorful decorations, and inside, there’s a giant dome above the main area, it looks super special!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/22.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "I love the decoration, and even more the history and culture of Oran!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/23.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "Are you ready to see the stars young explorer!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/24.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "We are ready!! My friend has his telescope and I have my flashlight.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/25.mp3",
              },

              {
                //number 25
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "Perfect! Tonight the sky is clear, we might even see a shooting star!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/26.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "WOAH! It was amazing Omar, good job my friend!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/27.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "Woah look at your chechia Omar. It’s perfect to show that we are explorers!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/28.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "Exactly Ace the chechia is not just a hat, it’s part of the traditions that makes Oran so special."
                        : "Exactly Ace the chechia is a part of the traditions here in Oran.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/29.mp3"
                        : "audios/region3/adventure1/005.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "It’s like a treasure from the past that we still wear today as much as the Guandora for men."
                        : "we still wear today as much as the Guandora for men.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/30.mp3"
                        : "audios/region3/adventure1/006.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "I love how every piece of clothing is telling a story about the place.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/31.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "Look how the Oran Blouza can steal lights from all the other dresses, it’s so colorfull and pretty.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/32.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "Yes The embroidery and decorations make it stand out especially in celebrations and big events. it’s a symbol of elegance!!"
                        : "The decorations and embroidery make it shine, especially during big events. It’s a symbol of beauty!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/33.mp3"
                        : "audios/region3/adventure1/007.mp3",
              },
              {
                //number 33
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "I can imagine us wearing these clothes on special occasions!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/34.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "I really feel like we are part of the adventure.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/35.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text":
                    "Glad that you are enjoying your time Ace!! Now it’s time for a puzzle game!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/36.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "Are you still excited to complete the journey Ace ??",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/37.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "Yes of course Omar what is the destination now!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/38.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg3.jpg",
                "text": "Our next stop is Arzew lighthouse!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/39.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text": "This lighthouse is so bright and looks amazing.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/40.mp3",
              },

              {
                //number 40
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    userAge > 6
                        ? "It’s one of the oldest lighthouses in Algeria, built in 1800 and works today to guide the boats especially at night."
                        : "It’s one of the oldest lighthouses in Algeria, built in 1800, and still helps guide boats.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/41.mp3"
                        : "audios/region3/adventure1/008.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text": "At night? How?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/42.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    userAge > 6
                        ? "It is equipped with a red light that flashes every 5 seconds. It is built on a small island in the sea standing 22.4 meters tall."
                        : "It has a red light that flashes and stands tall on a small island in the sea.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/43.mp3"
                        : "audios/region3/adventure1/009.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text": "It looks so cool, but how can we get there? ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/44.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "You can take a boat ride with one of the fishermen from the port.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/45.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "Just about 15 minutes and you will get a close-up view of the lighthouse!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/46.mp3",
              },
              {
                //number 47
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "Now let’s take the boat my friend to reach the lighthouse!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/47.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "Woah! The view is stunning, our next trip to Oran will be so enjoyable!  ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/48.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "Make sure to check the weather Ace, I would recommend visiting Oran in the summer.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/49.mp3",
              },
              {
                //number 50
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    userAge > 6
                        ? "It is hot and you can enjoy swimming in the beaches. Winter can be rainy and colder so it’s not the best time for outdoor fun!"
                        : "you can enjoy swimming in the beaches. Winter can be cold so it’s not the best time for outdoor fun!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/50.mp3"
                        : "audios/region3/adventure1/0010.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "I will absolutely take your advice into consideration!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/51.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "Do you want to see another wonder of the Ottomans in Algeria?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/52.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text": "YAY! New exploration!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/53.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg4.jpg",
                "text":
                    "The Bey palace is exactly what are you looking for. It is an incredible piece of history from the Ottoman era.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/54.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text": "That sounds awesome, what makes it so special?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/55.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "The palace is full of amazing things like beautiful painted callings and gardens, and It was once the home of the Beys.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/56.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text": " Now, it is restored to show off it’s old beauty!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/57.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text": "The Beys? Who are they?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/58.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    userAge > 6
                        ? "The rulers of Oran were called Beys .They were the leaders who made important decisions during the Ottoman empire."
                        : "The rulers of Oran were called Beys .They were the leaders  during the Ottoman empire.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/59.mp3"
                        : "audios/region3/adventure1/0011.mp3",
              },
              {
                //number 60
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "They were 6 in total, this palace was their home and the center of power in Oran!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/60.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text": "that's so cool!!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/61.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "now its time to show us your skills in a mini game Ace!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/62.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "I’m not the one that should!! Young explorer show us his skills.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/63.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "Looks like it’s young explorer turn!! Let’s see if you can beat Ace.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/64.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "That was so much fun my friend. You have a memory of an elephant!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/65.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "Welcome back explorers, I see that you are enjoying the adventure!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/66.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "Yes, it’s so much fun!! Now let’s dive into some history Omar.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/67.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text": "Wow, You are in for a real surprise Ace!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/68.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    userAge > 6
                        ? "You have explored the Ottoman culture in the previous adventures but now let’s dive into another iconic culture."
                        : "You have explored the Ottoman culture, now let’s dive into another iconic culture.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/69.mp3"
                        : "audios/region3/adventure1/0012.mp3",
              },
              {
                //number 70
                "bg": "assets/backgrounds/region3/adventure1/bg5.jpg",
                "text":
                    "And if we say iconic culture we talk about the Islamic culture discovering the stunning Ben Badis Mosque.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/70.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "It is special due to its incredible mix of Andalusian and Maghreb architecture.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/71.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "It feels like we stepped into a fairy tail world full of history and wonders!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/72.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Yes, the mosque has stunning designs with lovely patterns, colorful tiles and tall arches.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/73.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "You can spot this in its huge dome and beautiful door made with wood and bronze!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/74.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Impressive!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/75.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "The mosque is huge and it has two large prayer halls, one for men and the other for women.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/76.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "It becomes one of the symbols of the city and many tourists come here to admire it!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/77.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "That’s incredible it must be breathtaking to see up close!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/78.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Looks like you are getting hungry Ace!! I have got something that will make your stomach rumbles even more!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/79.mp3",
              },

              {
                //number 80
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Oupsie, I better grab some food before we start!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/80.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Are you ready for the ultimate food adventure in Oran? Let’s kick it off with Seffa.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/81.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Seffa? what’s that?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/82.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    userAge > 6
                        ? "It’s couscous, but sweet! It is made with sugar, cinnamon, raisins and almond you can say it’s a dessert and a meal, all in one!!"
                        : "It’s couscous, but sweet! you can say it’s a dessert and a meal, all in one!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/83.mp3"
                        : "audios/region3/adventure1/0014.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Sweet couscous!! That looks Tasty.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/84.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Young explorer! It’s time to make your own version of Seffa, Are you ready?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/85.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    userAge > 6
                        ? "Next, we have Hrira, it is a warn spicy soup made with tomatoes, chickpeas and meat, perfect for rainy days!!"
                        : "Next, we have Hrira, it is a warn spicy perfect for rainy days!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/86.mp3"
                        : "audios/region3/adventure1/0015.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Yummy soup! What else?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/87.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    userAge > 6
                        ? "You can’t miss Kalb El Louz, a sweet cake made with almonds and honey. It’s soft chewy and full of delicious flavors!"
                        : "You can’t miss Kalb El Louz, a sweet cake famous here in oran.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    userAge > 6
                        ? "audios/region3/adventure1/88.mp3"
                        : "audios/region3/adventure1/0016.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Woah! We will definitely need a big appetite for all this delicious food my friend.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/89.mp3",
              },

              {
                //number 90
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Get ready to use all your energy in the next mini game Ace!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/90.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "Ready young explorer?? Let’s go !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/91.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text":
                    "Good job little explorer!! Now let’s head to Telemcen!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure1/92.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure1/bg6.jpg",
                "text": "YAY! Another amazing adventure let’s go my friend!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure1/93.mp3",
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
