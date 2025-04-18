import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:project_2cp_eq11/miniGames/logic.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class Region2Adv1 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region2Adv1({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region2Adv1State createState() => _Region2Adv1State();
}

class _Region2Adv1State extends State<Region2Adv1>
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

          /*case 5:
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
                        correctIndex: 2,
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
            }*/
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

          /*case 17:
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
            }*/

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
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"FINALLY !!!we have reached the great EAST ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec1.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"she must be around here we need to find her ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec2.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"I’m wondering where Racha is",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec3.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"were you talking about me ? hehe ",
                "speakerIcon2": "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha1.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"It’s RACHA ... she is hiding somewhere !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec4.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"come find me first , I am behind the big yellow building",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha2.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"Hello there! Welcome to the east of Algeria! I’m Racha, your guide for this adventure",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha3.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"you are still as playful as ever huh RACHA ? hiding from us ? ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec5.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"HeHeHe",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha4.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"I’m so excited… we just came from the north We had an amazing time there,",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec6.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"what Incredible things have you prepared for us this time?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec7.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"You chose the perfect time to visit my region! With me, you’ll explore the east of Algeria.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha5.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"First, we’ll visit Constantine, where the bridges are so high, it feels like you’re walking in the clouds!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha6.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"Along the way, there will be fun mini-games, tricky puzzles, and lot of cool things to learn about this wilayas.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha7.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"Lets GOOOOOO !!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec8.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":"I’ve got something fun to show you quick, follow me , let’s head to the left!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha8.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"We are in one of the most amazing ancient cities in the east of Algeria!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha9.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"There are still so many stories and memories hidden behind every place and monument.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha10.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"The young explorer and I are fascinated by ancient times and old memories",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec9.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"So, let’s start with one of the most famous and special places here in Constantine—The Sidi M’Cid Bridge!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha11.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"It’s super high, about 175 meters above the ground. When people walk across it, it feels like they are walking in the sky!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha12.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"This amazing bridge was built a long time ago, in 1912, by a French engineer named Aubert",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha13.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"Today it is the first destination to visit here in constantine.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha14.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"Hmm… I see that people in Constantine are really proud of their city!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec10.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"speaking about people, I heared that they are conserving their old tradition by my grandpa,is it right?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec11.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"Yeah,that is right , the culture is so important here , for example clothes ... ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha15.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"Men wear Burnos ,with chachia while women usualy wear djeba fergani,gandora usually white etc..",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha16.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":"Now, let’s figure out this clothes in a fun game that’s allow you to discover our traditional clothes",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha17.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Now let's travel before the french colonization to the AHMED BEY PALACE ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha18.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"The Ahmed Bey Palace is still standing strong after all these years? I’m so inspired by its ancient architecture",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec12.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"We’re going back to the Ottoman era, when Algeria was full of stories and brave leaders. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha19.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"This beautiful palace was built between 1825 and 1835 by Ahmed Bey, the last ruler of Constantine before the French arrived.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha20.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Before we dive deeper in history you need something important. Every great explorer needs a nice hat to discover history!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha21.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Nice peak , let’s finish discovering this palace explorer  !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha22.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Look around! The palace has tall doors made of carved wood, colorful tiles on the walls ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha23.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"It has also a beautiful balcony that gives a beautiful view on  peaceful courtyards",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha24.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Wow! This place is amazing! The Ottomans really knew how to build beautiful palaces. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec13.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Look at all the details. It's like a palace from a fairy tale!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec14.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Exactly! Since you've been paying close attention, this is the perfect time to put your observation skills to the test ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha25.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Are you ready? Let’s go !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha26.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"I know you’re all interested in Algeria’s history and its amazing architecture… but we’re not done yet!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha27.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Another destination !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec15.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Let’s take the car to our new destination  !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha28.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"This place is really special to the city ! It’s a wonderful mix of culture, history, and traditions",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha29.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"It was built a long time ago and is an important place for prayer",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha30.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Look at its big dome and tall towers! Inside, it is quiet and peaceful, with beautiful designs on the walls.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha31.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"This mosque is not just for praying, it’s also a part of Constantine’s history",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha32.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"WOAH! What can be the relation of this mosque and history?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec16.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"It is a crucial part of Constantine’s history. It was built long time ago when Algeria was ruled by the Ottoman Empire. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha33.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"It shows the beautiful Ottoman-style architecture.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha34.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"For many years, people have come here to pray, learn, and gather. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha35.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"It is a special place that connects the past and the present of the city.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec17.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"And It’s giving the Ahmed bey palace architecture, Right !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec18.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"Exactly, and now let’s wrap up our journey with a fun mini-game. Ready to put your memory to the test?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/Racha36.mp3",
              },{
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":"YAAY !! Let’s GOO",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/fennec19.mp3",
              },
              
              
            ],
            onDialogueEnd: () {
             /* userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["completed"] =
                  true;
              Navigator.pop(context);
              Navigator.pop(context);*/
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
                  Material(
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
                  SizedBox(width: screenWidth * 0.01), // Spacing
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
