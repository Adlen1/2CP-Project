/*I want to write a documentation that describes the user flow diagram in which I have the folowing:
ince the user opens the app he has two options create a profile if he doesnt have one or select an existing profile and then he gets directed to the main page where he has 5 options...

give me the structure how to write it */
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/quiz_rules_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/Screens/Region3/pickTrash.dart';
import 'package:project_2cp_eq11/Screens/Region3/fixWall.dart';

class Region3Adv2 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region3Adv2({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region3Adv2State createState() => _Region3Adv2State();
}

class _Region3Adv2State extends State<Region3Adv2>
    with SingleTickerProviderStateMixin {
  bool lockview = false;

  @override
  void initState() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, 2);
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

          case 6:
            {
              updateDialogueIndex();
              pauseView("Mechouar Palace").then((_) {
                startTyping();
              });
              break;
            }

          case 16:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure2/bg2.jpg",
                        items: [
                          "assets/icons/region3/adventure2/tissue.png",
                          "assets/icons/region3/adventure2/hose.png",
                          "assets/icons/region3/adventure2/bucket.png",
                          "assets/icons/region3/adventure2/broom.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Grab the broom",
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
                      (context) => PpickTrash(profileNb: widget.profileNbr),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 21:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 5,
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
          case 23:
            {
              updateDialogueIndex();
              pauseView("Mansorah").then((_) {
                startTyping();
              });
              break;
            }
          case 35:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure2/bg3.jpg",
                        items: [
                          "assets/icons/region3/adventure2/pen.png",
                          "assets/icons/region3/adventure2/hammer.png",
                          "assets/icons/region3/adventure2/mic.png",
                          "assets/icons/region3/adventure2/charger.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick a tool to fix the wall ",
                        correctIndexes: [1],
                      ),
                ),
              ).then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FixWall(profileNb: widget.profileNbr),
                  ),
                ).then((_) {
                  updateDialogueIndex();
                  startTyping();
                });
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
                        gameNb: 3,
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
          case 43:
            {
              updateDialogueIndex();
              pauseView("Sidi Boumediene Mosque").then((_) {
                startTyping();
              });
              break;
            }
          case 49:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        profileNb: widget.profileNbr,
                        bg: "assets/backgrounds/region3/adventure2/bg4.jpg",
                        items: [
                          "assets/icons/region3/adventure2/l1.png",
                          "assets/icons/region3/adventure2/l4.png",
                          "assets/icons/region3/adventure2/l3.png",
                          "assets/icons/region3/adventure2/l2.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Choose a lantern !!",
                        correctIndexes: [0, 1, 2, 3],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }

          case 58:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RulesGamePage(
                        profileNbr: widget.profileNbr,
                        gameNb: 2,
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

          case 7:
            {
              pauseView("Mechouar Palace");
              break;
            }
          case 24:
            {
              pauseView("Mansorah");
              break;
            }
          case 44:
            {
              pauseView("Sidi Boumediene Mosque");
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
      List<int> targetIndexes = [21, 38, 58];

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
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "Oh, welcome to the most admired wilaya in the Gharb of Algeria ‘Telemcen’ ! Here, we’ll uncover many secrets together.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/1.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "You and I are going to have so much fun exploring the wonders hidden between its mountains, history, and culture",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/2.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "From ancient ruins to breathtaking landscapes, get ready for an unforgettable adventure!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/3.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text": "Really,We’re ready for another adventure Let’s GOO.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/4.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "Nice! I heard from Racha that you're interested in old architecture, right?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/5.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "Yes, I love to explore how monuments were built a long time ago!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/6.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg1.jpg",
                "text":
                    "Then let’s pack our things and head to the Mechouar Palace!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/7.mp3",
              },
              {
                //number 7
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    old
                        ? "This is the Mechouar Palace, a real treasure from the past ! It was built in the 13th century by the Zianid kings"
                        : "This is Mechouar Palace,it was built in the 13th century",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/8.mp3"
                        : "audios/region3/adventure2/111.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "They made Telemcen their capital and This palace was like their royal home ! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/9.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    " It had beautiful gardens, decorated walls, and large open courtyards. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/10.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text": "What a beautiful palace ! But what was its aim ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/11.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    old
                        ? "The kings used it to rule, welcome visitors, and even enjoy music and poetry,you can still feel the royal air in every corner!"
                        : "The kings at that time used to live and welcome their visitors,long time ago",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/12.mp3"
                        : "audios/region3/adventure2/1212.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Wow, it’s really old! But… how did they build something so big without machines?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/13.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Great question, Ace! Long ago, there were no big machines. But the builders were very smart and worked hard.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/14.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    old
                        ? "They used stones, wood and simple tools to build. It took a lot of time and teamwork that’s what makes it so special!"
                        : "With simple materials ans tools,they have been able to built this Amazing place",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/15.mp3"
                        : "audios/region3/adventure2/1515.mp3",
              },
              {
                //number 15
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Cool, I see that there is a lot of  places that the old ruler of Algeria were in….",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/16.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "WOW What a brutal wind !! The palace seems dirty now !Grab the broom and let’s clean the trash young explorer",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/17.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text": "Nice let’s clean the place !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/18.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Excellent work young explorer !! The palace is tidy now !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/19.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "There is different palaces in Algeria but each has its own story !! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/20.mp3",
              },
              {
                //number 20
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Now talking about differences how about going into SPOT THE DIFFERENCES MINI GAME…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/21.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text": "YAY !! Young explorer it’s games time!! ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/22.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text":
                    "Excellent ,but we are not done yet ,Ready to uncover the secrets of OLD Telemcen",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/23.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg2.jpg",
                "text": "Let’s head to Mansorah !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/24.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text": "The color of this monument is magnificent….",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/25.mp3",
              },

              {
                //number 25
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    old
                        ? "This place has seen centuries of history. Every stone tells a story, each corner tells secrets of the past."
                        : "This palace has seen centeries of history,every corener tells us a secret from the past",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/26.mp3"
                        : "audios/region3/adventure2/2626.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "This mosque was built 700 years ago,it has a tall minaret, big enough to be seen from far away, and it helped call people to prayer.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/27.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "Even if parts of it are damaged today, you can still see how grand and strong it was.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/28.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "The walls, arches, and stones all tell us stories from a time when this place was full of life, learning, and faith!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/29.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text": "What happened to the mosque after all these years?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/30.mp3",
              },

              {
                //number 30
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    old
                        ? "After the city was left behind, no one came to pray here anymore. The wind, rain, and sun slowly broke the walls"
                        : "After the city was left behind,no one came to pray here.The wind and rain slowly broke the walls",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/31.mp3"
                        : "audios/region3/adventure2/3131.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "That’s why the mosque became a quiet place full of memories.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/32.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "Why is the minaret still standing while the rest is ruined?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/33.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    old
                        ? "Because the minaret was built very strong and tall. It was made to last and to be seen from far away."
                        : "Because it was built very strong and tall,since it was the principal monument ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/34.mp3"
                        : "audios/region3/adventure2/3434.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "That’s why it survived, even when the other parts of the mosque fell apart.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/35.mp3",
              },
              {
                //number 35
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "Oh No! Part of the Mansorah wall is broken! Which tool should we use to fix it young explorer ? ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/36.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text": "Nice one my friend you should be proud of yourself !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/37.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "Now,since you have find the secret of Mansorah,Can you find the hidden objects…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/38.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text": "Sure! Let’s give it a try!!!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/39.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "That was fun! I didn’t know ruins could hide so many cool things.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/40.mp3",
              },

              {
                //number 40
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "You’ve got a good eye, explorer! But there’s still one more place I’d love to show you. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/41.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "It’s a very peaceful and beautiful site, very different from here…",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/42.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text": "YAY!! What is the destination now ?  ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/43.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg3.jpg",
                "text":
                    "To the mosque of Sidi Boumediene; a place full of wisdom, poetry, and peace. Follow me!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/44.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "It is not just a mosque, it’s also the resting place of one of the most loved scholars and wise men in Tlemcen.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/45.mp3",
              },
              {
                //number 45
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "Who was Sidi Boumediene?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/46.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    old
                        ? "He was a very kind and smart man who lived many centuries ago. People came from far away to hear his words and learn from him."
                        : "He was a very smart man who lived here. People came here to learn from him",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/47.mp3"
                        : "audios/region3/adventure2/4747.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "It’s really quiet here… I like it.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/48.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "Yes, it’s a place where people come to think, to pray, and to feel peace. This mosque was built in the 13th century long time ago !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/49.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "In the evenings the mosque glowed with warm lanterns , but oh no they are off help us light them again !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/61.mp3",
              },
              {
                //number 50
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "Wow ! What a nice choice it would look magical now!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/50.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "There’s also a peaceful garden with orange trees and flowers. ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/51.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    old
                        ? "When you walk around, you can feel the calm all around you, like the place is telling stories from the past."
                        : "When you walk around, you can feel the calm all around you, like the place is telling stories from the past.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/52.mp3"
                        : "audios/region3/adventure2/5252.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "Wow, it’s so different from Mansorah!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/53.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "Exactly — Mansorah was strong and grand, but this place is soft and peaceful. Both are part of Telemcen’s amazing story.",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/54.mp3",
              },
              {
                //number 55
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "Now i know,we have visited a lot of places and i tell you different stories,you enjoy it ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/55.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "Yes,it was Amazing!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/56.mp3",
              },

              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    "Then,i prepare for you another mini game that will confirme your memory,Ready?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice": "audios/region3/adventure2/57.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "YAY! A memory game let’s go my friend !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/58.mp3",
              },
              {
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text":
                    old
                        ? "Now I can ensure that you leave this region with all the information in you’re head it was a good time with you guys,See you!"
                        : "Now I can ensure that you will leave this region with all the information in your head,see you!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Omar",
                "voice":
                    old
                        ? "audios/region3/adventure2/59.mp3"
                        : "audios/region3/adventure2/5959.mp3",
              },
              {
                //number 60
                "bg": "assets/backgrounds/region3/adventure2/bg4.jpg",
                "text": "I really enjoyed the trip Omar thank you !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region3/adventure1/Omar.png",
                "textBoxIcon":
                    "assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region3/adventure2/60.mp3",
              },
            ],
            onDialogueEnd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RulesPage(profileNbr: widget.profileNbr, quizNbb: 3),
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
