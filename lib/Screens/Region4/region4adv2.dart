import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/Screens/Region2/selectJewel.dart';
import 'package:project_2cp_eq11/Screens/Region2/selectWhateverFrom5.dart';
import 'package:project_2cp_eq11/Screens/quiz_rules_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class Region4Adv2 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const Region4Adv2({
    Key? key,
    required this.profileNbr,
    required this.region,
    required this.adventure,
    required this.initIndex,
  }) : super(key: key);

  @override
  _Region4Adv2State createState() => _Region4Adv2State();
}

class _Region4Adv2State extends State<Region4Adv2>
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

          case 9:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg1.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Derra.png",
                          "assets/icons/region4/adventure2/Tagelmust.png",
                          "assets/icons/region4/adventure2/Melhfa.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Derra", "Tagelmust", "Melhfa"],
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
            case 11:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region4/adventure2/bg1.jpg",
                        profileNb: widget.profileNbr,
                        items: [
                          "assets/icons/region4/adventure2/hat1.png",
                          "assets/icons/region4/adventure2/hat2.png",
                          "assets/icons/region4/adventure2/hat3.png",
                          "assets/icons/region4/adventure2/hat4.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick your tagelmust",
                        correctIndexes: [1],
                      ),
                ),
              ).then((_) {
                updateDialogueIndex();
                startTyping();
              });
              break;
            }
          case 12:
            {
              updateDialogueIndex();
              pauseView("Erg Admer Dunes").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][0] =
                  true;
              break;
            }

          case 22 : 
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg2.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Saharan_Cheetah.png",
                          "assets/icons/region4/adventure2/Horned_Viper.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Saharan Cheetah", "Horned Viper"],
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

          case 25:
            {
              updateDialogueIndex();
              pauseView("Djanet").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][1] =
                  true;
              break;
            }

          case 34 : 
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg3.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Aghroum.png",
                          "assets/icons/region4/adventure2/Takoula.png",
                        ],
                        imgWidth: 0.2,
                        imgHeight: 0.42,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Aghroum", "Takoula"],
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

          case 36:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region4/adventure2/bg3.jpg",
                        profileNb: widget.profileNbr,
                        items: [
                          "assets/icons/region4/adventure2/food1.png",
                          "assets/icons/region4/adventure2/food2.png",
                          "assets/icons/region4/adventure2/food3.png",
                          "assets/icons/region4/adventure2/food4.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pack food for the picnic",
                        correctIndexes: [0,1,2,3],
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
              updateDialogueIndex();
              pauseView("Tassili n’Ajjer").then((_) {
                startTyping();
              });
              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["landmarks"][2] =
                  true;
              break;
            }

            case 56: 
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChooseItem(
                        bg: "assets/backgrounds/region4/adventure2/bg4.jpg",
                        profileNb: widget.profileNbr,
                        items: [
                          "assets/icons/region4/adventure2/draw1.png",
                          "assets/icons/region4/adventure2/draw2.png",
                          "assets/icons/region4/adventure2/draw3.png",
                          "assets/icons/region4/adventure2/draw4.png",
                        ],
                        imgHeight: 0.45,
                        imgWidth: 0.16,
                        text: "Pick your drawing !",
                        correctIndexes: [0,1,2,3],
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

          case 10:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg1.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Derra.png",
                          "assets/icons/region4/adventure2/Tagelmust.png",
                          "assets/icons/region4/adventure2/Melhfa.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Derra", "Tagelmust", "Melhfa"],
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
          case 13:
          {
            pauseView("Erg Admer Dunes");
            break;
          }
          case 23 : 
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg2.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Saharan_Cheetah.png",
                          "assets/icons/region4/adventure2/Horned_Viper.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Saharan Cheetah", "Horned Viper"],
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

          case 26:
          {
            pauseView("Djanet");
            break;
          }

          case 35 : 
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewElements(
                        profileNb: widget.profileNbr,

                        bg: "assets/backgrounds/region4/adventure2/bg3.jpg",
                        items: [
                          "assets/icons/region4/adventure2/Aghroum.png",
                          "assets/icons/region4/adventure2/Takoula.png",
                        ],
                        imgWidth: 0.16,
                        imgHeight: 0.4,
                        speakerIcon1:
                            "assets/icons/region1/adventure1/fennec.png",
                        speakerIcon2:
                            "assets/icons/region4/adventure1/Maria.png",
                        text: ["Aghroum", "Takoula"],
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

          case 43:
          {
            pauseView("Tassili n’Ajjer");
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
      List<int> targetIndexes = [35, 64, 91];

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
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Welcome back Ace my friend!! Here we are in Illizi",
                //"speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Ace !! Where are you hiding ?",
                //"speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Ace!! I bet he went to visit his family hehe",
                //"speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Surprise!!  How am I looking ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Woah ! What beautiful clothes. HA so that’s why you vanished you were dressing up!! !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"HAHA I was getting ready it took me some time to fid my Deraa this long white robe that keeps me cool in the desert",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"My face is wrapped with Tagelmust, a blue turban worn by men",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Maria ! You are also wearing a traditional cloth !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Yes , this is Melehfa a long cloth covering all around my head and body ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Woah ! That’s amazing !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Yes in Sahara clothes are all made to protect from the heat , the weather is always hot..",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg1.jpg",
                "text":"Young explorer you should pick a Tagelmust to protect you from the sand the wind is strong!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"Now you are ready to explore ! As you can see , this BIG YELLOW  SPACE is called the great dunes of Erg Admer ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":" It is a vast place covered with a huge amount of golden sand",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"It is like walking on the moon but... warmer and softer",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"Right but even in this hot and dry land , life still finds a way",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"That’s true we can see this throw the fauna!! Are you ready my friend ?!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"Let’s find out together",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"The horned viper for example is a snake that buries itself in the sand in order to hide from the heat",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"SNAKES are so dangerous young explorer",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":" Exactly you should be careful when you see a snake !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"We have also The Saharan cheetah, it is rare and endangered  ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"It is my favorite animal, it is so speed ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"Now young explorer it’s time to test your knowledge throw a matching game !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"YAY! A new mini game , let’s go!!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg2.jpg",
                "text":"Shiw that was funny , you are smart my friend !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"OW welcome back Ace and little explorer , Can you believe ? This beautiful town in here in the desert",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"No way! I thought the desert was just sand and.. more sand !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"Yes most of it , but this is Djanet , it is different an oasis where trees and gardens grow",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"This paradise is surrounded by two long mountain ranges",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"It is an old town where the Tuareg people live , they are called  blue people because of their blue clothes !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"WOW blue like my nice taglemust !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"HEHE , yes !! And guess what! Tuareg make special food to stay strong",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":" like Aghroum ; a flat bread cooked on hot stones and Takoula which is a porridge made from barely and milk",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"I can confirm that they are so delicious !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"The weather is nice we should absolutely go on a picnic today !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"It’s a good idea but first little explorer you should pick what to eat !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"Now we are ready for a real adventure in the desert ! What is the next destination Maria ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"Hold on Ace I prepered a fun mini game for you ! Can you spot the differences ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"HUM !! Little explorer It’s our time to shine !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"Good job little explorer !! Are you ready to continue the adventure !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"YAY !! what’s next !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg3.jpg",
                "text":"Exploring the Tassili n’Ajjer , it is a magical place in the desert , with huge rocks and ancient drawings on the wall !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"HA like the drawings in Tamanrasset !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"Yes people from long ago left pictures of animals and their life on the rocks !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"Woah ! It’s like stepping in time ain’t it !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"That’s true Ace",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"The view here is amazing , the rocks look like they are reaching the sky",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"It is a very quiet and peaceful place , and what’s special about the place is the sunsets ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"The sun in the evening hides letting a beautiful mix of colors in the sky !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"That seems breathetaking",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"The tassili n’Ajjer is a UNESCO Heritage Site,  it is one of the most important places in the world !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"People come from all over the globe to  see its natural beauty !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"I love the desert it is so beautiful",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"Now young explorer I have a challenge for you ! Can you draw something that represents the desert on the rocks",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },
              {
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"HUM I want to draw something also!! I think a giant rock would perfectly represent the desert ",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"What about you my friend ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"Good choice young explorer ! You really assimilated the desert !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"Now do you know what Tassili means ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"A Traveling agency ??",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"No Ace, it means a flat mountain !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"That’s right It is exactly what Tassili n’Ajjer looks like !",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"I think it’s the best time to go for a little mini game right ?",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"That would be super cool !! Let’s go my friend !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"I really enjoyed the adventure Maria thank you very much !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/fennec_dialogue_box.png",
                "speaker": "fennec",
                "voice": "audios/region4/adventure2/.mp3",
              },{
                "bg": "assets/backgrounds/region4/adventure2/bg4.jpg",
                "text":"The pleasure is mine Ace ! Come whenever you want and bring the little explorer with you , he is so smart !!",
                "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
                "speakerIcon2": "assets/icons/region4/adventure1/Maria.png",
                "textBoxIcon":"assets/icons/region1/adventure1/mehdi_dialogue_box.png",
                "speaker": "Maria",
                "voice": "audios/region4/adventure2/.mp3",
              },
            ],
            onDialogueEnd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RulesPage(profileNbr: widget.profileNbr, quizNbb: 4),
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
