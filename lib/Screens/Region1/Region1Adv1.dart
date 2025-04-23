import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class Region1Adv1 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region1Adv1({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region1Adv1State createState() => _Region1Adv1State();
}

class _Region1Adv1State extends State<Region1Adv1>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final userData = Provider.of<DataProvider>(context, listen: false).userData;

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

          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FindNpc(
                        bg: "assets/backgrounds/region1/adventure1/bg2.jpg",
                        npcPaths: ["assets/icons/region1/adventure1/mehdi.png"],
                        imgWidth: 0.4,
                        imgHeight: 0.4,
                        imgOpacity: 1,
                        text: "Find Mehdi",
                        topOffsets: [0.6],
                        rightOffsets: [0.65],
                        topcheck: 0.15,
                        rightcheck: 0.15,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 14:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region1/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region1/adventure1/books.png",
                          "assets/icons/region1/adventure1/toothbrush.png",
                          "assets/icons/region1/adventure1/backpack.png",
                          "assets/icons/region1/adventure1/candy.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick your backpack",
                        correctIndexes: [2],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 16:
            {
              pauseView("The Casbah");
              updateDialogueIndex();
              Future.delayed(Duration(seconds: 3), () {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][0] =
                    true;
              });
              break;
            }
          case 21:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        bg: "assets/backgrounds/region1/adventure1/bg3.jpg",
                        imagePaths: [
                          "assets/icons/region1/adventure1/algeria.png",
                          "assets/icons/region1/adventure1/france.png",
                        ],
                        imgWidth: 0.38,
                        imgHeight: 0.55,
                        text: "Choose Algeria's flag",
                        correctIndex: 0,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 24:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        bg: "assets/backgrounds/region1/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region1/adventure1/haik.png",
                          "assets/icons/region1/adventure1/djellaba.png",
                        ],
                        imgWidth: 0.21,
                        imgHeight: 0.45,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["El Hayek", "Djellaba"],
                        textWidth: 0.26,
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

          case 26:
            {
              pauseView("The Martyrs' Memorial");
              updateDialogueIndex();
              Future.delayed(Duration(seconds: 3), () {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][1] =
                    true;
              });
              break;
            }

          case 32:
            {
              pauseView("The Hamma gardens");
              updateDialogueIndex();
              Future.delayed(Duration(seconds: 3), () {
                startTyping();
              });
              break;
            }

          case 36:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        bg: "assets/backgrounds/region1/adventure1/bg5.jpg",
                        items: [
                          "assets/icons/region1/adventure1/tiger.png",
                          "assets/icons/region1/adventure1/lion.png",
                          "assets/icons/region1/adventure1/monkey.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Tiger", "Lion", "Monkey"],
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

          case 25:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 1,
                        levelNb: 1,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Puzzle"][0] =
                    true;
              });
              break;
            }

          case 38:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 2,
                        levelNb: 1,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Memory"][0] =
                    true;
              });

              break;
            }

          case 42:
            {
              pauseView("Algiers great mosque");
              updateDialogueIndex();
              Future.delayed(Duration(seconds: 3), () {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][2] =
                    true;
              });
              break;
            }

          case 48:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        bg: "assets/backgrounds/region1/adventure1/bg6.jpg",
                        imagePaths: [
                          "assets/icons/region1/adventure1/icon1.png",
                          "assets/icons/region1/adventure1/icon2.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.49,
                        text: "Choose the appropriate outfit",
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

          case 55:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 3,
                        levelNb: 1,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Spot"][0] =
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

          case 17:
            {
              pauseView("The Casbah");
              break;
            }

          case 25:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        bg: "assets/backgrounds/region1/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region1/adventure1/haik.png",
                          "assets/icons/region1/adventure1/djellaba.png",
                        ],
                        imgWidth: 0.21,
                        imgHeight: 0.45,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["El Hayek", "Djellaba"],
                        textWidth: 0.26,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping(
                    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                  );
                } else if (result == -1) {
                  updateDialogueIndex();
                  startTyping(
                    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                  );
                }
              });
              break;
            }

          case 27:
            {
              pauseView("The Martyrs' Memorial");
              break;
            }
          case 33:
            {
              pauseView("The Hamma gardens");
              break;
            }
          case 37:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        bg: "assets/backgrounds/region1/adventure1/bg5.jpg",
                        items: [
                          "assets/icons/region1/adventure1/tiger.png",
                          "assets/icons/region1/adventure1/lion.png",
                          "assets/icons/region1/adventure1/monkey.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Tiger", "Lion", "Monkey"],
                        textWidth: 0.2,
                      ),
                ),
              ).then((result) {
                if (result == 1) {
                  startTyping(
                    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                  );
                } else if (result == -1) {
                  updateDialogueIndex();
                  startTyping(
                    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                  );
                }
              });
              break;
            }
          case 43:
            {
              pauseView("Algiers great mosque");
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
      List<int> targetIndexes = [25, 38, 55];

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
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text":
                    "Welcome, young explorer, to the first adventure of our journey!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec1.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text":
                    "Today, we’re heading to the heart of Algeria… The amazing city of Algiers!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec2.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text":
                    "it’s the capital and I am sure it’s full of surprises!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec3.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text":
                    "I’ve heard that Algiers is a city by the sea, with white buildings that shine under the sun.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "/audios/region1/adventure1/fennec 4.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text":
                    "speaking of the buildings… I think we are near the place of my old friend Mehdi",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 5.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg1.jpg",
                "text": "Can you help me find him ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 6.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "ACE ! My old friend! It’s been a while! Still sniffing out new adventures, huh?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 1.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "You know me! And this time, I’m not going alone… I’ve brought a young explorer with me!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 8.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "Curious, brave… and ready to uncover all the secrets of the northern region.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 9.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "Oh yes… When I was your age, I used to travel with my family through this beautiful region.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 2.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "You can say I know  every corner of it! That’s why I decided to join you on this adventure.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 3.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "But enough talking… It’s time to dive into the adventure!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 4.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "Together, we’ll embark on two exciting adventures, exploring worlds filled with games, fun challenges, and amazing surprises!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 5.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text": "Cool, see? I told you, you wouldn’t be bored!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 10.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "Oh, that’s for sure! Grab your backpack! and let’s dive in ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 6.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "excelent .. now the real adventure starts in its oldest part… the Casbah.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 7.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg2.jpg",
                "text":
                    "The Casbah? I’ve heard about it from my grandfather. Can we see it in depth?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 12.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "It’s a city that stands between the present and the past",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 8.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "tiny streets, old houses with colorful doors here every stone tells a story from Algeria’s past.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 9.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text": "The past of Algeria?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 13.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "Yes, as you can see, this city was at the heart of the fight against the French enemy,",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 10.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "they wanted to erase Algerian culture and traditions. That’s why we, as Algerians, are committed to preserve them today.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 11.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text": "then what traditions it holds here?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 15.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "Oh! It stands for the different dishes and clothes that show our identity.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 12.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "Here in Algiers, for example, men wear the Djellaba and women wear the Karakou or el Hayek .",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 13.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text":
                    "Want to see more? Let’s play a puzzle to explore it together!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 14.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg3.jpg",
                "text": "Well done , now let’s Move near by another location !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 15.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "Ow, what a big monument it stands for what exactly  ,  is it  history?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 17.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "Bingo! This monument is called the Martyrs’ Memorial. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 16.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "It was built in 1982 to honor the memory of Algeria’s brave heros who fought for our independence.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 17.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "It stands high on a hill in Algiers and looks like three giant palm leaves. From up there, you can see the whole city.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 18.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "Wow,I heared that Algiers is named the green wilaya ,any landscape to discover?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 18.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg4.jpg",
                "text":
                    "True,a beautiful green space is waiting for us , let’s get there",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 19.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "Here,whrer’s the secret of the algerien nature is inveiled,It’s a kingdom of plants and animals",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 20.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "Imagine a giant forest so tall that almost touch the sky,with colorful flowers and palms!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 21.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text": "AWESOME !!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 20.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "Next door,We can find a ZOO that holds different animals : Lions , tigers , playful monkeys …",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 22.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text": "I may find my cousin there !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 22.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "I know it’s a lot of interesting information,let’s get now into a memory Game ...",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 23.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "It looks like the stories of Algiers are not mystery to you anymore…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 24.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "But be careful this city isn’t just about the past and memories! today, Algiers is also modern and full of life!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 25.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text":
                    "And to show you,Let’s head to the majestic Great Mosque of Algiers!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 26.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg5.jpg",
                "text": "Modern Algiers, here we come!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 23.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    " heard the tower of this mosque is so tall… do you think I could spot my home all the way from the desert?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 25.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Haha! If anyone can spot his home from up there, it’s you, ACE !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 27.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "But seriously, here we are at the Great Mosque of Algiers built in 2020",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 29.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "It’s the biggest mosque in Africa and one of the largest one in the world!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 30.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "The prayer hall is huge therefore many people come here not just to pray, but also to learn and explore.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 31.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "come on ... let’s pick the appropriate outfit for the mosque ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 32.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "good job !  now u see that tall tower? It’s called a minaret, From the top, you can see the city, the sea and far beyond.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 33.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "There’s even a library, a museum, and beautiful gardens all around. It’s a peaceful and special place for everyone.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 34.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Wow! The difference between the old and new buildings is incredible!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 27.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Exactly! They say the fennec has super watchful eyes, I can confirm that…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 35.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Let’s see if our young explorer’s eyes are just as powerful as yours !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 36.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "I think a fun game of Spot the Differences will put your observation skills to the test. Ready? Let’s go!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 37.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text": "Let’s GOOO !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure1/fennec 28.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Well done, young explorer! You’ve got the eyes of an eagle and the curiosity of a true adventurer.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 38.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "It was a real pleasure exploring Algiers with you! But your journey doesn’t stop here…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 39.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure1/bg6.jpg",
                "text":
                    "Good luck on your next adventures keep your backpack ready and your eyes wide open! See you soon!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 40.mp3",
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
                  /* Material(
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
