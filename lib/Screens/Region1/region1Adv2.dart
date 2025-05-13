import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/Screens/quiz_rules_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

/// ============================================================================
/// Region1Adv2.dart
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
class Region1Adv2 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region1Adv2({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region1Adv2State createState() => _Region1Adv2State();
}

class _Region1Adv2State extends State<Region1Adv2>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 2);
    int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) > 6
        ? GameLogic.setRegion(context, widget.profileNbr, 0)
        : GameLogic.setRegion(context, widget.profileNbr, 1);
  }

  final AudioPlayer _player = AudioPlayer();

  void _stopAudio() async {
    await _player.stop();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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

          case 8:
            {
              updateDialogueIndex();

              pauseView("The Royal Mausoleum of Mauretania").then((_) {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][3] =
                    true;
              });

              break;
            }

          case 13:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => QCM(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg2.png",
                        imagePaths: [
                          "assets/icons/region1/adventure2/rock.png",
                          "assets/icons/region1/adventure2/scissor.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.49,
                        text: "Pick a move",
                        correctIndex: 1,
                        check: false,
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
              updateDialogueIndex();

              pauseView("Mount Chenoua").then((_) {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][3] =
                    true;
              });

              break;
            }

          case 22:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg3.png",
                        items: [
                          "assets/icons/region1/adventure2/fig.png",
                          "assets/icons/region1/adventure2/vineyard.png",
                          "assets/icons/region1/adventure2/olive.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Fig", "Vineyard", "Olive"],
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

          case 24:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 5,
                        levelNb: 1,
                        fromAdv: true,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 27:
            {
              updateDialogueIndex();

              pauseView("Roman ruins").then((_) {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][4] =
                    true;
              });

              break;
            }

          case 31:
            {
              updateDialogueIndex();

              pauseView("The Roman Theater").then((_) {
                startTyping();
                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][5] =
                    true;
              });

              break;
            }

          case 34:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region1/adventure2/bg5.png",
                        profileNb: widget.profileNbr,
                        items: [
                          "assets/icons/region1/adventure2/ball.png",
                          "assets/icons/region1/adventure1/toothbrush.png",
                          "assets/icons/region1/adventure2/water.png",
                          "assets/icons/region1/adventure2/camera.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Grab the camera",
                        correctIndexes: [3],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();

                pauseView("Tipaza Archaeological Museum!").then((_) {
                  startTyping();
                });
              });
              break;
            }

          case 42:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        levelNb: 1,
                        gameNb: 4,
                        fromAdv: true,
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
              updateDialogueIndex();
              pauseView("Tipaza port").then((_) {
                startTyping();
              });

              break;
            }

          case 47:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FindNpc(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg9.png",
                        npcPaths: [
                          "assets/backgrounds/region1/adventure2/Rectangle 52.png",
                          "assets/backgrounds/region1/adventure2/Rectangle 52.png",
                        ],
                        imgWidth: 0.1,
                        imgHeight: 0.1,
                        imgOpacity: 0,
                        text: "Catch the fish",
                        topOffsets: [0.6, 0.58],
                        rightOffsets: [0.69, 0.54],
                        topcheck: 0.005,
                        rightcheck: 0.01,
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 49:
            {
              updateDialogueIndex();

              pauseView("Tipaza beach").then((_) {
                startTyping();
              });

              break;
            }

          case 53:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg8.png",
                        items: [
                          "assets/icons/region1/adventure2/chorba.png",
                          "assets/icons/region1/adventure2/couscous.png",
                          "assets/icons/region1/adventure2/chekchouka.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Chorba", "Couscous", "Chekchouka"],
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

          case 56:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 6,
                        levelNb: 1,
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
            print('\x1B[33mStart typing will called\x1B[0m');

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
              pauseView("The Royal Mausoleum of Mauretania");
              break;
            }

          case 19:
            {
              pauseView("Mount Chenoua");
              break;
            }

          case 23:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg3.png",
                        items: [
                          "assets/icons/region1/adventure2/fig.png",
                          "assets/icons/region1/adventure2/vineyard.png",
                          "assets/icons/region1/adventure2/olive.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Fig", "Vineyard", "Olive"],
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

          case 28:
            {
              pauseView("Roman ruins");
              break;
            }

          case 32:
            {
              pauseView("The Roman Theater");
              break;
            }

          case 35:
            {
              pauseView("Tipaza Archaeological Museum!");
              break;
            }

          case 44:
            {
              pauseView("Tipaza port");
              break;
            }

          case 50:
            {
              pauseView("Tipaza beach");
              break;
            }

          case 54:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region1/adventure2/bg8.png",
                        items: [
                          "assets/icons/region1/adventure2/chorba.png",
                          "assets/icons/region1/adventure2/couscous.png",
                          "assets/icons/region1/adventure2/chekchouka.png",
                        ],
                        imgWidth: 0.18,
                        imgHeight: 0.38,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region1/adventure1/mehdi.png",
                        text: ["Chorba", "Couscous", "Chekchouka"],
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
      List<int> targetIndexes = [24, 42, 56, dialogues.length - 1];
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
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text":
                    "Welcome our young explorer in the second adventure of this journey",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 1.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text":
                    "And now with the discovery of a new wilaya situated in the northern region of Algeria, which is Tipaza.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 2.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text": "Tipaza!! Interesting!!! We are all ears.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 1.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text":
                    "Tipaza is a beautiful coastal town located west of Algiers along the Mediterranean Sea.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 3.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text":
                    "It has fascinating nature, and it is famous for its rich history.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 4.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text": "WOOW!! History!! Tell us more.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 2.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text": "Tipaza was once a Roman city over 2,000 years ago!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 5.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text":
                    "Today, you can still see the ruins of this ancient civilization.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 6.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg1.png",
                "text": "Let's change location.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 7.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "I imagine that you are asking, WHAT IS THIS GIANT ROUND...",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 8.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "Rock? It’s a rock, right? Just like the game rock-paper-scissors!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 3.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "How about playing a round of rock-paper-scissors, and then I’ll tell you what this thing is?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 9.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text": "That looks fun... I’m in!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 4.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text": "I'll choose paper... Now, pick your move!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 10.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "That was fun... Back to our subject... This is not a rock.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 11.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "It is The Royal Mausoleum of Mauretania, where the last Berber queen and king of Mauretania were buried a long time ago.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 12.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text":
                    "And it is such an important monument to the history of our country.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 13.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text": "HMM… You’re telling me to revise my lessons, Mehdi??",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 6.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg2.png",
                "text": "Yes, as you should!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 14.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "See here, that’s Mount Chenoua. This beautiful mountain is near Tipaza.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 15.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "Some people say it looks like a giant sleeping! It’s full of old stories and legends.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 16.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text": "WOW, I want to go there! It looks amazing!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 7.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "I invite you to come to Tipaza. There are also fertile lands where olive trees, fig trees, and vineyards grow!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 17.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "EMM, I can’t now, sorry. I’m invited to a new mini-game with my friend!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 8.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "Let’s go have some fun, my friend!! See you later, Mehdi.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 9.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "Woah, Mehdi, I’ve never seen a talented explorer like my friend!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 10.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text":
                    "You did great, young explorer!! You deserve a trip around Tipaza to explore its beautiful ruins.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 18.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg3.png",
                "text": "RUINS!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 11.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg4.png",
                "text":
                    "It’s an amazing place, right? As you can see, these Roman ruins give us a glimpse into the past.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 19.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg4.png",
                "text":
                    "With old houses, streets, and walls telling the story of the ancient Roman civilization in Tipaza.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 20.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg4.png",
                "text": "Is that everything for the ruins?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 12.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg4.png",
                "text": "Of course not, we still have the Roman theater.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 21.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg5.png",
                "text":
                    "It is a large stone theater where people used to watch plays and performances.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 22.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg5.png",
                "text":
                    "OWW, nice! I like this THEATER!! There's so much history in Tipaza!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 13.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg5.png",
                "text": "Bring the camera! Let me take a photo here!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 14.mp3",
              },

              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text": "What’s that building over there?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 17.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text":
                    "Ah, that’s the Tipaza Archaeological Museum! It was built in 1955 and has a lot of cool things from the past.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 23.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text":
                    "It’s full of objects that show how people lived a long time ago. Want to take a look inside?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 24.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text": "Definitely! What can we find there?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 18.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text":
                    "Inside, you’ll see things like ancient mosaics. One of the most famous ones is the Mosaic of the Captives.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 25.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text":
                    "The museum has glass objects, statues, coins, and jewelry too. It’s a great way to learn about the city’s history.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 26.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text": "I can’t wait to check this out!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 19.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text":
                    "My friend, are you ready for a new mini-game? Let’s go!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 27.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg6.png",
                "text": "Well done! Now let’s move to another location nearby!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure1/mehdi 15.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text":
                    "This is the Tipaza Port. It’s a charming spot by the sea, where fishermen once brought fresh fish.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 28.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text":
                    "And now it's a perfect place to relax and enjoy the peaceful views.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 29.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text": "Woah, fish!! I love fish!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 22.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text":
                    "Tipaza is known for its delicious seafood. Come on, let’s catch some fish!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 30.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text":
                    "Woah! I want to eat fish every day! I'm going to live in Tipaza!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 24.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg7.png",
                "text":
                    "Speaking of food, let’s take a seat on the beach, and I’ll tell you about all the delicious dishes here.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 31.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "In general, the northern region is famous for its traditional food—not just seafood.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 32.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "People here eat couscous on Fridays. It’s a dish made with tiny grains and vegetables.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 33.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "There’s also chorba, a spicy soup made with vegetables and meat.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 34.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "And don't forget chekchouka! It’s delicious, colorful, tasty, and full of vitamins!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "mehdi",
                "voice": "audios/region1/adventure2/mehdi 35.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text": "WOW! That sounds so yummy!!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 27.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text": "But... do you know what time it is?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec 28.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text": "It’s gaming time... See you later, Mehdi!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec29.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "That was fast... you're really getting better at this!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec30.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "The North was really beautiful... just as expected from the heart of Algeria.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec31.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "There are so many other places, monuments, and traditions we didn’t have time to explore.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec32.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "But that’s okay—we can always come back here later, you know?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec33.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text":
                    "Now it’s time for our last challenge: a final quiz to review everything we’ve learned!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec34.mp3",
              },
              {
                "bg": "assets/backgrounds/region1/adventure2/bg8.png",
                "text": "I'll be waiting for you—so don’t take too long!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region1/adventure2/fennec35.mp3",
              },
            ],
            onDialogueEnd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RulesPage(profileNbr: widget.profileNbr, quizNbb: 1),
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
                          message:
                              "Are you sure you want to go back? Your progress will be lost.",
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
                  /*  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                        _stopAudio();
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
