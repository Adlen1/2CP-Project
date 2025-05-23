import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/Screens/Region2/selectJewel.dart';
import 'package:project_2cp_eq11/Screens/Region2/selectWhateverFrom5.dart';
import 'package:project_2cp_eq11/Screens/quiz_rules_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

/// ============================================================================
/// Region2Adv2.dart
/// ============================================================================
///
/// This page represents an adventure in the game. It handles:
///
/// - Dialogue-based storytelling using a `DialogueBox` widget.
/// - Navigation to interactive events and minigames.
/// - hiding all the elemnts to showcase the scene (background).
/// - Age-based modifications.
///
///  pushed by regions_page.dart
/// ============================================================================
class Region2Adv2 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region2Adv2({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region2Adv2State createState() => _Region2Adv2State();
}

class _Region2Adv2State extends State<Region2Adv2>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 2);
    int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) > 6
        ? GameLogic.setRegion(context, widget.profileNbr, 1)
        : GameLogic.setRegion(context, widget.profileNbr, 2);
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
      required Function pauseView,
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

          case 2:
            {
              updateDialogueIndex();

              pauseView("Cab Carbon").then((_) {
                startTyping();
              });

              break;
            }
          case 10:
            {
              updateDialogueIndex();

              pauseView("The Monkeys Peak").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][3] =
                  true;

              break;
            }

          case 14:
            {
              updateDialogueIndex();

              pauseView("The Monkeys Peak").then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ViewElements(
                          profileNb: widget.profileNbr,

                          bg: "assets/backgrounds/region2/adventure2/bg4.jpg",
                          items: [
                            "assets/icons/region2/adventure2/Barbary_macaque.png",
                          ],
                          imgWidth: 0.2,
                          imgHeight: 0.4,
                          speakerIcon1:
                              "assets/icons/region1/adventure1/fennec.png",
                          speakerIcon2:
                              "assets/icons/region2/adventure1/Racha.png",
                          text: ["Barbary macaque"],
                          textWidth: 0.2,
                        ),
                  ),
                ).then((result) {
                  if (result == 1) {
                    startTyping();
                  } else if (result == -1) {
                    pauseView("The Monkeys Peak").then((_) {
                      startTyping();
                    });
                  }
                });
              });
            }

          case 15:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg4.jpg",
                        imagePaths: [
                          "assets/icons/region2/adventure2/banana.png",
                          "assets/icons/region2/adventure2/orange.png",
                          "assets/icons/region2/adventure2/apple.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.49,
                        text: "Give it food",
                        correctIndex: 0,
                        check: false,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 20:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 4,
                        levelNb: 2,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Match"][1] =
                    true;
              });
              break;
            }

          case 22:
            {
              updateDialogueIndex();
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][4] =
                  true;
              pauseView("Casbah of Béjaïa").then((_) {
                startTyping();
              });

              break;
            }

          case 40:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FindNpc(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg6.jpg",
                        npcPaths: [
                          "assets/icons/region1/adventure1/mehdi.png",
                          "assets/icons/region1/adventure1/mehdi.png",
                          "assets/icons/region1/adventure1/mehdi.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.2,
                        imgOpacity: 0,
                        text: "Collect the olive",
                        topOffsets: [0.3, 0.34, 0.28],
                        rightOffsets: [0.41, 0.565, 0.7],
                        topcheck: 0.05,
                        rightcheck: 0.04,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 43:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg5.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Kabyle_dress.png",
                          "assets/icons/region2/adventure2/Avernous.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Kabyle dress", "Avernous"],
                        textWidth: 0.2,
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

          case 46:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg5.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Thaessavth.png",
                          "assets/icons/region2/adventure2/Amesyas.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Thaessavth", "Amesyas"],
                        textWidth: 0.2,
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

          case 47:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SelectJewel(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg5.jpg",
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 52:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 3,
                        levelNb: 2,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Spot"][1] =
                    true;
              });
              break;
            }

          case 56:
            {
              updateDialogueIndex();
              pauseView("Aokas beach").then((_) {
                startTyping();
              });

              break;
            }

          case 58:
            {
              updateDialogueIndex();
              pauseView("Aokas caves").then((_) {
                startTyping();
              });

              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][5] =
                  true;

              break;
            }
          case 62:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SelectFrom5(
                        bg: "assets/backgrounds/region2/adventure2/bg8.jpg",
                        items: [
                          "assets/icons/region2/adventure2/crystal1.png",
                          "assets/icons/region2/adventure2/crystal2.png",
                          "assets/icons/region2/adventure2/crystal3.png",
                          "assets/icons/region2/adventure2/crystal4.png",
                          "assets/icons/region2/adventure2/crystal5.png",
                        ],
                        imgHeight: 0.25,
                        imgWidth: 0.15,
                        text: "What would you take",
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 71:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg7.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Tajine_zitoune.png",
                          "assets/icons/region2/adventure2/Aghrum_lehwal.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Tajine zitoune", "Aghrum lehwal"],
                        textWidth: 0.2,
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

          case 72:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 6,
                        levelNb: 2,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Choose"][1] =
                    true;
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

          case 3:
            {
              pauseView("Cab Carbon");
              break;
            }
          case 11:
            {
              pauseView("The Monkeys Peak");
              break;
            }

          case 15:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg4.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Barbary_macaque.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Barbary macaque"],
                        textWidth: 0.2,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping();
                } else if (result == -1) {
                  pauseView("The Monkeys Peak");
                }
              });
              break;
            }

          case 23:
            {
              pauseView("Casbah of Béjaïa");

              break;
            }

          case 44:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg5.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Kabyle_dress.png",
                          "assets/icons/region2/adventure2/Avernous.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Kabyle dress", "Avernous"],
                        textWidth: 0.2,
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

          case 47:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg5.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Thaessavth.png",
                          "assets/icons/region2/adventure2/Amesyas.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Thaessavth", "Amesyas"],
                        textWidth: 0.2,
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

          case 72:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure2/bg7.jpg",
                        items: [
                          "assets/icons/region2/adventure2/Tajine_zitoune.png",
                          "assets/icons/region2/adventure2/Aghrum_lehwal.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.41,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Tajine zitoune", "Aghrum lehwal"],
                        textWidth: 0.2,
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
      required Function stopAudio,
    }) {
      // Define skip indexes
      List<int> targetIndexes = [20, 52, 72, dialogues.length - 1];
      stopAudio();

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
                "bg": "assets/backgrounds/region2/adventure2/bg1.jpg",
                "text": "Here we are, I hope you enjoy the journey!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/1.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg1.jpg",
                "text":
                    "I can’t wait to see all the wonders of Béjaïa with you.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/2.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg1.jpg",
                "text":
                    "Our adventure begins at Cap Carbon, a stunning landmark that rises from the Mediterranean Sea.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/3.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    "Cap Carbon is known for its rich history and breathtaking beauty.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/4.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    "At its top, you’ll see a lighthouse that has stood 220 meters above sea level for over a century.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/5.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Wow What a spectacular view!!"
                        : "Wow What a nice view!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/6.mp3"
                        : "audios/region2/adventure2/111.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    userAge > 6
                        ? "In addition to the view, it has a historical significance because it has been a strategic location along various periods of history."
                        : "It has also a historical significance because it has been a strategic location along various periods of history.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/7.mp3"
                        : "audios/region2/adventure2/777.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text": "It looks very calm and peaceful!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/8.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    userAge > 6
                        ? "We will discover many peacefull places today! Tell me Ace do you like monkeys?"
                        : "We will see a lot of peacefull places today!! Tell me Ace do you like monkeys?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/9.mp3"
                        : "audios/region2/adventure2/999.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    "Monkeys!! Yes! they are friendly, and I think we can find some here in Béjaïa",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/10.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Right! We can see them at the Monkey’s Peak. It’s a winding road leading west of the city toward a high summit."
                        : "Right! We can see them at Monkey Peak! It’s a small road that goes up a big hill!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/11.mp3"
                        : "audios/region2/adventure2/1111.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg3.jpg",
                "text":
                    userAge > 6
                        ? "It overlooks the bay from 430 meters high, offering a panoramic view of the Djurdjura Mountains and both Kabylies."
                        : "From the top, you can see the big blue sea and tall mountains all around!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/12.mp3"
                        : "audios/region2/adventure2/1212.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg3.jpg",
                "text":
                    "You'll see lots of monkeys—and even the Barbary macaque!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/13.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg3.jpg",
                "text": "I really love Béjaïa—it’s full of marvelous places!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/14.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg3.jpg",
                "text":
                    "I know where to find a Barbary macaque! Come on, follow me!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/15.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text":
                    "I told you we would find him! He looks hungry! What do you think we should feed him, my friend?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/16.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text": "Nice! Monkeys eat bananas, young explorer!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/17.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text":
                    "We should definitely come back to Béjaïa to feed the other monkeys!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/18.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text":
                    "Good idea! But first, you should remember these places!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/19.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text": "Of course, I revised my lessons this time!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/20.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text":
                    "Let’s see if our explorer remembers them too, so you can enjoy your next trip to Béjaïa!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/21.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text": "Well done, my friend.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/22.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg4.jpg",
                "text":
                    "Heading now to more cultural places and if we say culture, we are of course talking about the Casbah of Béjaïa",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/23.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Oh wow, there is a Casbah in Béjaïa too!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/24.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "Yes, It is an old town full of history and culture, built by the Almohads during the 1154 periods."
                        : "Yes, it's an old town rich in history and culture, built by the Almohads around 1154.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/25.mp3"
                        : "audios/region2/adventure2/2525.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "It stands as a witness to both French and Spanish occupation.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/26.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "Despite these harsh periods, the Casbah remains a symbol of our heritage. Today, It is classified as a national heritage site."
                        : "Despite difficult times, the Casbah remains a symbol of our heritage. Today, it is recognized as a national heritage.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/27.mp3"
                        : "audios/region2/adventure2/2727.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Béjaïa has a rich history, Racha!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/28.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Yes! And its traditions are equally meaningful. Let me tell you more about them!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/29.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Traditions! Are they the same as in Algiers?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/30.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "No, Ace. Each region has its own traditions. The Amazigh celebrate Yennayer every year!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/31.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Yennayer?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/32.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Yes, in the Amazigh language, 'yen' means 'first' and 'ayer' means 'month', and this is very meaningful.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/33.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "It marks the beginning of the Amazigh New Year. People celebrate the start of a new agricultural season during this time."
                        : "It marks the start of the Amazigh New Year, celebrated as the beginning of a new agricultural season.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/34.mp3"
                        : "audios/region2/adventure2/3434.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "WOAH! We celebrate it too! I didn’t know it's called Yennayer!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/35.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "There is another beautiful tradition known as 'olive picking'. It's a time when families and neighbors gather together.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/36.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "They enjoy wonderful moments in the midst of nature, and create lasting memories while picking olives."
                        : "They enjoy special moments in nature and create lasting memories while picking olives.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/37.mp3"
                        : "audios/region2/adventure2/3737.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "Once all the olives are harvested..."
                        : "Once all the olives are collected...",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/38.mp3"
                        : "audios/region2/adventure2/3838.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "THEY GATHER TO EAT THEM!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/39.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "HHHHH, No Ace! They transform them into what we call 'Zith Uzemmor' or 'olive oil'.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/40.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "That sounds fun! Let’s go pick some olives, young explorer!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/41.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "Yes, it is! But we’re not done yet! The Amazigh are also famous for their beautiful traditional clothes."
                        : "Yes, it is! We're not done yet — the Amazigh are also known for their amazing traditional clothes",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/42.mp3"
                        : "audios/region2/adventure2/4242.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Traditional clothes? like the dress you are wearing ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/43.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Exactly! Women wear the 'Kabyle dress', like mine. It’s colorful and has beautiful embroidery. Men wear 'Avernous'.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/44.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    userAge > 6
                        ? "The Kabyle dress is often worn with silver jewelry, reflecting the richness and heritage of the Berber traditions in Algeria"
                        : "The Kabyle dress is often worn with silver jewelry that reflects the richness and heritage of the Berber traditions in Algeria",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/45.mp3"
                        : "audios/region2/adventure2/4545.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Ooooh! Jewelry!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/46.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Like the 'thaessavth', which is a headpiece, and 'amesyas', a bracelet.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/47.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Now young explorer, would you like to help me choose a piece of jewelry to complete my outfit?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/48.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "Oh, nice choice! It would look great on you, Racha! You Amazigh folks are so stylish!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/49.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Choo choo!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/50.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "What?  Where? A new destination?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/51.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "No, Fennec! It’s fun time!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/52.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "True… Come on, explorer! Let’s have some fun!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/53.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Shiw... We are back!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/54.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "Ready to continue the adventure, Ace?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/55.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text": "YAAY! Another destination!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/56.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg5.jpg",
                "text":
                    "I am honored to show you Aokas, it is a small coastal town in the Béjaïa province",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/57.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    userAge > 6
                        ? "Aokas is located between the Mediterranean Sea and the Kabylie mountains. It is famous for its beautiful beaches and mysterious caves."
                        : "Aokas is a town between the Mediterranean Sea and the Kabylie mountains. It is known for its nice beaches and interesting caves.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/58.mp3"
                        : "audios/region2/adventure2/5858.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text": "WOAH! The caves—can we see them, please?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/59.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "These are the natural caves of Aokas. They're known for their beautiful rock formations and sparkling crystals.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/60.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "That's why you call them magical caves! They truly are!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/61.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "Wait! Before we go deeper in the cave, we need something to help us explore.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/62.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "I’d love a magical crystal! What about you? Pick one so we can see all the sparkly rocks inside!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/63.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "These caves are such a special place for exploration and enjoying nature. Aren’t they, young explorer?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/64.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text":
                    "Wait a second—we talked about the culture, history, traditions, and even caves!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/65.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg8.jpg",
                "text": "Racha, we forgot about the beaches...",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/66.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "Don’t worry, Ace—we’re coming! Aokas is a coastal town, so it has warm and pleasant weather.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/67.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "you see this breathtaking beach, where the sand is soft and warm, the water sparkles in the sunlight.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/68.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    userAge > 6
                        ? "The air smells fresh and salty and the sun makes everything feels bright and happy. It is the perfect place to play, swim and relax!!"
                        : "The fresh air and the bright sun make it the perfect place to play, swim, and relax.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure2/69.mp3"
                        : "audios/region2/adventure2/6969.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text": "And build sandycastles!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/70.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "Yes! Ace, before you leave to the next game, let me show you the traditional food of Béjaïa.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/71.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    userAge > 6
                        ? "The Amazigh are famous for Tajine Zitoune, a dish made with olives and meat. Aghrum Lehwal is a bread made with many natural ingredients."
                        : "The Amazigh are known for Tajine Zitoune, a meat and olive dish, and Aghrum Lehwal, a bread made with natural ingredients.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/72.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text": "Games time!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/73.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "And that’s a wrap, young explorer! You’ve traveled through beaches, caves, mountains, and culture — all in one adventure!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/74.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text": "We had so much fun with you, Racha!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/75.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "Every adventure needs a little break, Ace—until the next one!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/76.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text":
                    "And for you, explorer pack your memories, keep your explorer hat ready, and never stop being curious!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure2/77.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure2/bg7.jpg",
                "text": "See you later, Racha, for a new adventure!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure2/78.mp3",
              },
            ],
            onDialogueEnd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RulesPage(profileNbr: widget.profileNbr, quizNbb: 2),
                ),
              );
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
