import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

/// ============================================================================
/// Region2Adv1.dart
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
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 1);
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

          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FindNpc(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure1/bg1.jpg",
                        npcPaths: ["assets/icons/region1/adventure1/mehdi.png"],
                        imgWidth: 0.3,
                        imgHeight: 0.3,
                        imgOpacity: 0,
                        text: "Find Racha",
                        topOffsets: [0.15],
                        rightOffsets: [0.45],
                        topcheck: 0.1,
                        rightcheck: 0.1,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 15:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure1/bg1.jpg",
                        imagePaths: [
                          "assets/icons/region2/adventure1/left_arrow.png",
                          "assets/icons/region2/adventure1/up_arrow.png",
                          "assets/icons/region2/adventure1/right_arrow.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.49,
                        text: "Head to the left",
                        correctIndex: 0,
                        check: false,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();

                pauseView("The Sidi M’Cid Bridge").then((_) {
                  startTyping();
                });
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][0] =
                    true;
              });
              break;
            }

          case 26:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region2/adventure1/Djeba_fergani.png",
                          "assets/icons/region2/adventure1/bornus.png",
                          "assets/icons/region2/adventure1/Gandora.png",
                        ],
                        imgWidth: 0.15,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Djeba fergani", "Bornus", "Gandora"],
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

          case 32:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region2/adventure1/bg3.jpg",
                        profileNb: widget.profileNbr,
                        items: [
                          "assets/icons/region2/adventure1/hat_1.png",
                          "assets/icons/region2/adventure1/hat_2.png",
                          "assets/icons/region2/adventure1/hat_3.png",
                          "assets/icons/region2/adventure1/hat_4.png",
                        ],
                        imgHeight: 0.35,
                        imgWidth: 0.12,
                        text: "Pick your hat",
                        correctIndexes: [0, 1, 2, 3],
                        checkTop: 0.12,
                        checkRight: -0.01,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 42:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region2/adventure1/bg3.jpg",
                        imagePaths: [
                          "assets/icons/region2/adventure1/bus.png",
                          "assets/icons/region2/adventure1/car.png",
                          "assets/icons/region2/adventure1/train.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.49,
                        text: "Pick the car",
                        correctIndex: 1,
                        check: false,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();

                pauseView("The Great Mosque of Constantine").then((_) {
                  startTyping();
                });
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][2] =
                    true;
              });
              break;
            }

          case 27:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 1,
                        levelNb: 2,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();

                pauseView("Ahmed Bey Palace ").then((_) {
                  startTyping();
                });
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][1] =
                    true;
              });
              break;
            }

          case 39:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 5,
                        levelNb: 2,
                        fromAdv: true,
                        widthScaler: 1.2,
                        heightScaler: 1.2,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
                userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Find"][1] =
                    true;
              });
              break;
            }

          case 54:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 2,
                        levelNb: 2,
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

          case 16:
            {
              pauseView("The Sidi M’Cid Bridge");

              break;
            }

          case 28:
            {
              pauseView("Ahmed Bey Palace ");

              break;
            }

          case 43:
            {
              pauseView("The Great Mosque of Constantine");

              break;
            }

          case 27:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region2/adventure1/bg2.jpg",
                        items: [
                          "assets/icons/region2/adventure1/Djeba_fergani.png",
                          "assets/icons/region2/adventure1/bornus.png",
                          "assets/icons/region2/adventure1/Gandora.png",
                        ],
                        imgWidth: 0.15,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region2/adventure1/Racha.png",
                        text: ["Djeba fergani", "Bornus", "Gandora"],
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
      List<int> targetIndexes = [27, 39, 54, dialogues.length - 1];
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
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "FINALLY!!! We have reached the great EAST!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/1.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "I’m wondering where Racha is.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/2.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "She must be around here. We need to find her.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/3.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "Were you talking about me? Hehe.",
                "speakerIcon2":
                    "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/4.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "It’s Racha... she’s hiding somewhere!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2":
                    "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/5.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "Come find me first. I’m behind the big yellow building.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2":
                    "assets/icons/region2/adventure1/hiddenRacha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/6.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "Hello there! Welcome to the East of Algeria! I’m Racha, your guide for this adventure.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/8.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "You’re still as playful as ever!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/9.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "Hehehe!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/10.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "I’m so excited… We just came from the North and had an amazing time there!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/11.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "What incredible things have you prepared for us this time?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/12.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "You chose the perfect time to visit my region! With me, you’ll explore the East of Algeria.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/13.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "First, we’ll visit Constantine, where the bridges are so high, it feels like you’re walking in the clouds!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/14.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "Along the way, there will be fun mini-games, tricky puzzles, and lots of cool things to learn about these wilayas.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/15.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text": "Let’s GOOOOOO!!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/16.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg1.jpg",
                "text":
                    "I’ve got something fun to show you—quick, follow me! Let’s head to the left!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/17.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "We are in one of the most amazing ancient cities in the East of Algeria!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/19.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "There are still so many stories and memories hidden behind every place and monument.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/20.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "The young explorer and I are fascinated by ancient times and old memories.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/21.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "So, let’s start with one of the most famous and special places here in Constantine—The Sidi M’Cid Bridge!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/22.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "It’s super high, about 175 meters above the ground. When people walk across it, it feels like they are walking in the sky!"
                        : "It’s super high. When people walk across it, it feels like they are walking in the sky!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/23.mp3"
                        : "audios/region2/adventure1/2323.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "This amazing bridge was built a long time ago, in 1912, by a French engineer named Aubert"
                        : "This amazing bridge was built a long time ago, in 1912, by a French man called Aubert",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/24.mp3"
                        : "audios/region2/adventure1/2424.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "Today, it’s the top place to visit here in Constantine.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/25.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "Hmm… I see that people in Constantine are really proud of their city!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/26.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Speaking of people, I heard from my grandpa that they are preserving their old traditions. Is that right?"
                        : "Speaking of people, my grandpa told me they’ve kept their old traditions, right?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/27.mp3"
                        : "audios/region2/adventure1/2727.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    "Yeah, that is right. Culture is very important here — for example, clothing...",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/28.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Men wear a burnous with a chachia, while women usually wear a djeba fergani or a white gandoura."
                        : "Men wear a burnous with a chachia, while women usually wear a djeba fergani or a gandoura.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/29.mp3"
                        : "audios/region2/adventure1/2929.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg2.jpg",
                "text":
                    userAge > 6
                        ? "Now, let’s explore these clothes through a fun game that lets you discover our traditional outfits!"
                        : "Now, let's figure out these clothes in a mini game!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/31.mp3"
                        : "audios/region2/adventure1/3131.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Now let's travel back to before French colonization — to the AHMED BEY PALACE.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/32.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "The Ahmed Bey Palace is still standing strong after all these years? I’m really inspired by its ancient architecture.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/33.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "We’re going back to the Ottoman era, when Algeria was full of stories and brave leaders.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/34.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "This beautiful palace was built between 1825 and 1835 by Ahmed Bey, the last ruler of Constantine before the French arrived."
                        : "This beautiful palace was built in 1825 by Ahmed Bey, the last ruler of Constantine before the French arrived.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/35.mp3"
                        : "audios/region2/adventure1/3535.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    userAge > 6
                        ? "Before we dive deeper into history you need something important. Every great explorer needs a nice hat to uncover the past!! "
                        : "Wait, You forgot to put on your explorer hat didn't you ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/36.mp3"
                        : "audios/region2/adventure1/3636.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Nice peak, let’s finish discovering this palace little explorer!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/38.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Look around! The palace has tall doors made of carved wood, colorful tiles on the walls.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/39.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "It has also a beautiful balcony that gives a beautiful view on peaceful courtyards",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/40.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Wow! This place is amazing! The Ottomans really knew how to build beautiful palaces.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/41.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Look at all the details. It's like a palace from a fairy tale!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/42.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "Exactly! Since you've been paying close attention, this is the perfect time to put your observation skills to the test ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/43.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text": "Are you ready? Let’s go!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/44.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text":
                    "I know you’re all interested in Algeria’s history and its amazing architecture… but we’re not done yet!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/45.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text": "Another destination!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/46.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg3.jpg",
                "text": "Let’s take the car to our new destination!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/47.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "This place is really special to the city! It’s a wonderful mix of culture, history, and traditions",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/49.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "It was built a long time ago and is an important place for prayer.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/50.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Look at its big dome and tall towers! Inside, it is quiet and peaceful, with beautiful designs on the walls.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/51.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "This mosque is not just for praying — it’s also a part of Constantine’s history.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/52.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "WOAH! What can be the relation of this mosque and history?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/53.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    userAge > 6
                        ? "It is a crucial part of Constantine’s history. It was built long time ago when Algeria was ruled by the Ottoman Empire."
                        : "It is an important part of Constantine’s history. It was built long time ago when Algeria was under the Ottoman Empire.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice":
                    userAge > 6
                        ? "audios/region2/adventure1/54.mp3"
                        : "audios/region2/adventure1/5454.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text": "It shows the beautiful Ottoman-style architecture.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/55.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "For many years, people have come here to pray, learn, and gather.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/56.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "It is a special place that connects the past and the present of the city.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/57.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text": "And it totally gives Ahmed Bey Palace vibes, right?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/58.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Exactly! And now, let’s wrap up our journey with a fun mini-game. Ready to put your memory to the test?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/59.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text": "YAAY!! Let’s GOO!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/60.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Choo choo! Who wants to explore the magical land of Bejaia? The train is leaving soon!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/61.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "We're coming... Wait, what? Where’s the train, Racha? I don’t see anything!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/62.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Oh Ace! The train is right here — in our imagination! Can’t you hear the 'choo choo'? It’s ready to take us to a land full of surprises!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/63.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Really? What’s in Bejaia, Racha? Are there big mountains to climb and nice seas to swim in?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/64.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "Of course! There are beautiful beaches, tall trees, and even more! There are also magical caves full of history and culture!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/65.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text":
                    "WOAH!! Did you hear that? MAGICAL CAVES! It sounds like the best adventure ever!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region2/adventure1/66.mp3",
              },
              {
                "bg": "assets/backgrounds/region2/adventure1/bg4.jpg",
                "text": "Choo choo! Hold on tight... Bejaia, here we come!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region2/adventure1/Racha.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Racha",
                "voice": "audios/region2/adventure1/67.mp3",
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
