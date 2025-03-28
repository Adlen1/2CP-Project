import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Region1/Region1Adv1.dart';
import 'package:project_2cp_eq11/Screens/Region1/choose_item.dart';
import 'package:project_2cp_eq11/Screens/Region1/find_npc.dart';
import 'package:project_2cp_eq11/Screens/Region1/qcm.dart';
import 'package:project_2cp_eq11/Screens/Region1/view_elements.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class Region1Adv2 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;

  const Region1Adv2({
    Key? key,
    required this.profileNbr,
    required this.region , 
    required this.adventure , 
  }) : super(key: key);

  @override
  _Region1Adv2State createState() => _Region1Adv2State();
}

class _Region1Adv2State extends State<Region1Adv2> with SingleTickerProviderStateMixin {

  bool lockview = false ;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<DataProvider>(context, listen: false).userData;


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String userName = userData["Profiles"]["Profile_${widget.profileNbr}"]["firstName"];

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
    }) {
      if (isTyping) {
        completeText();
      
    } else {
      switch (currentDialogueIndex) {
        case var i when i == dialogues.length - 1:
          onDialogueEnd?.call(); 
          return;

        

        
        

        case 8 :{
          pauseView("The Royal Mausoleum of Mauretania");
          updateDialogueIndex(); 
          break;
        }

        case 13 : {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QCM(
                bg: "assets/backgrounds/region1/adventure2/bg2.png", 
                imagePaths: [
                  "assets/icons/region1/adventure2/rock.png",
                  "assets/icons/region1/adventure2/scissor.png",
                ],
                imgWidth: 0.2, 
                imgHeight: 0.49, 
                text: "Pick a move",
                correctIndex: 0, 
                check: false,
              ),
            ),
          );
          updateDialogueIndex();
          break;
        }

        case 18 :{
          pauseView("Mount Chenoua");
          updateDialogueIndex(); 
          break;
        }

        case 22: {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewElements(
                bg: "assets/backgrounds/region1/adventure1/bg3.jpg",
                items: [
                  "assets/icons/region1/adventure2/fig.png",
                  "assets/icons/region1/adventure2/vineyard.png",
                  "assets/icons/region1/adventure2/olive.png",
                ],
                imgWidth: 0.18,
                imgHeight: 0.38,
                speakerIcon1: "assets/icons/region1/adventure1/fennec.png",
                speakerIcon2: "assets/icons/region1/adventure1/mehdi.png",
                text: ["Fig", "Vineyard" , "Olive"],
                textWidth: 0.2,
              ),
            ),
          ).then((result) {
            if (result == 1) {
              updateDialogueIndex();
            } else if (result == -1) {
              startTyping();
            }
          });
          break;
        }

        case 27 :{
          pauseView("Roman ruins");
          updateDialogueIndex(); 
          break;
        }

        case 31 :{
          pauseView("The Roman Theater");
          updateDialogueIndex(); 
          break;
        }

        case 34: {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseItem(
                bg: "assets/backgrounds/region1/adventure2/bg5.png",
                items: [
                  "assets/icons/region1/adventure2/ball.png",
                  "assets/icons/region1/adventure1/toothbrush.png",
                  "assets/icons/region1/adventure2/water.png",
                  "assets/icons/region1/adventure2/camera.png",
                ],
                imgHeight: 0.45,
                imgWidth: 0.16,
                text: "Grab the camera",
                correctIndex: 3,
              ),
            ),
          ).then((_) {
            pauseView("Tipaza Archaeological Museum!");
            updateDialogueIndex();
          });

          break;
        }


        case 43 :{
          pauseView("Tipaza port");
          updateDialogueIndex(); 
          break;
        }

        case 47 :{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>FindNpc(
                bg:"assets/backgrounds/region1/adventure2/bg9.png" , 
                npcPaths: ["assets/backgrounds/region1/adventure2/Rectangle 52.png","assets/backgrounds/region1/adventure2/Rectangle 52.png"], 
                imgWidth: 0.1, 
                imgHeight: 0.1,
                imgOpacity: 0, 
                text: "Catch the fish",
                topOffsets: [0.6,0.58],
                rightOffsets: [0.69,0.54],
                topcheck: 0.005,
                rightcheck: 0.01,
                )
            ),
          );
          updateDialogueIndex();
          break;
        }

        case 49 :{
          pauseView("Tipaza beach");
          updateDialogueIndex(); 
          break;
        }

        case 53: {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewElements(
                bg: "assets/backgrounds/region1/adventure1/bg5.jpg",
                items: [
                  "assets/icons/region1/adventure2/chorba.png",
                  "assets/icons/region1/adventure2/couscous.png",
                  "assets/icons/region1/adventure2/chekchouka.png",
                ],
                imgWidth: 0.18,
                imgHeight: 0.38,
                speakerIcon1: "assets/icons/region1/adventure1/fennec.png",
                speakerIcon2: "assets/icons/region1/adventure1/mehdi.png",
                text: ["Chorba", "Couscous" , "Chekchouka"],
                textWidth: 0.2,
              ),
            ),
          ).then((result) {
            if (result == 1) {
              updateDialogueIndex();
            } else if (result == -1) {
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
    }) {
      if (isTyping) {
        completeText();
      
    } else {
      switch (currentDialogueIndex) {
        case -1 :{
          Navigator.pop(context);
        }

        case 9 :{
          pauseView("The Royal Mausoleum of Mauretania");
          break;
        }

        case 19 :{
          pauseView("Mount Chenoua");
          break;
        }

        case 23: {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewElements(
                bg: "assets/backgrounds/region1/adventure1/bg3.jpg",
                items: [
                  "assets/icons/region1/adventure2/fig.png",
                  "assets/icons/region1/adventure2/vineyard.png",
                  "assets/icons/region1/adventure2/olive.png",
                ],
                imgWidth: 0.18,
                imgHeight: 0.38,
                speakerIcon1: "assets/icons/region1/adventure1/fennec.png",
                speakerIcon2: "assets/icons/region1/adventure1/mehdi.png",
                text: ["Fig", "Vineyard" , "Olive"],
                textWidth: 0.2,
              ),
            ),
          ).then((result) {
            if (result == 1) {
              startTyping();
            } else if (result == -1) {
              updateDialogueIndex();
            }
          });
          break;
        }


        case 28 :{
          pauseView("Roman ruins");
          break;
        }

        case 32 :{
          pauseView("The Roman Theater");
          break;
        }

        case 35 :{
          pauseView("Tipaza Archaeological Museum!");
          break;
        }

        case 44 :{
          pauseView("Tipaza port");
          break;
        }

        case 50 :{
          pauseView("Tipaza beach");
          break;
        }

        case 54: {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewElements(
                bg: "assets/backgrounds/region1/adventure1/bg5.jpg",
                items: [
                  "assets/icons/region1/adventure2/chorba.png",
                  "assets/icons/region1/adventure2/couscous.png",
                  "assets/icons/region1/adventure2/chekchouka.png",
                ],
                imgWidth: 0.18,
                imgHeight: 0.38,
                speakerIcon1: "assets/icons/region1/adventure1/fennec.png",
                speakerIcon2: "assets/icons/region1/adventure1/mehdi.png",
                text: ["Chorba", "Couscous" , "Chekchouka"],
                textWidth: 0.2,
              ),
            ),
          ).then((result) {
            if (result == 1) {
              startTyping();
            } else if (result == -1) {
              updateDialogueIndex();
            }
          });
          break;
        }
        
        default:
          updateDialogueIndex();
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
          lockview: lockview,
          dialogues: [
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Welcome our young explorer in the second adventure of this journey",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "and now with the discovery of a new wilaya situated in the northern region of Algeria which is Tipaza",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Tipaza !! Interesting !!! We are all ears",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Tipaza is a beautiful coastal town located west Algiers along the Mediterranean sea",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "It has a fascinating nature and it is famous with its rich history",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "WOOW !! History !! Tell us more",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Tipaza was once a Roman city over 2,000 years ago !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Today, you can still see the ruins of this ancient civilization.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg1.png",
              "text": "Come with me, i'll show you something",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "I may imagine that you are asking WHAT IS THIS GIANT ROUND...",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "Rock ? It’s a rock right ? just like the game rock paper scissor !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "How about playing a round of rock paper scissor and then I will tell you what is this thing ?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "that looks fun... I am in !!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "I'll choose paper... Now, pick your move!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "That was fun... Back to our subject... This is not a rock ",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "It is The Royal Mausoleum of Mauretania where the last Berber queen and king of mauretania were buried a long time ago",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "and it is such an important monument to the history of our country.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "HMM… You are telling me to revise my lessons Mehdi??",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg2.png",
              "text": "Yes as you should!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "See here, that’s the Mount Chenoua, this beautiful mountain is near Tipaza.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "Some people say it looks like a giant sleeping! It’s full of old stories and legends.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "WOW, I want to go there, it looks amazing!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "I invite you to come to tipaza, there are also fertile lands where olive trees, fig trees, and vineyards grow!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "EMM, i can’t now sorry i’m invited with $userName a new mini game!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "Let’s go have some fun $userName!! See you later Mehdi",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "Woah Mehdi, i have never seen as a talented explorer as $userName !!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "You did great young explorer !! You deserve a travel around tipaza to explore its beautiful ruins",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg3.png",
              "text": "RUINS!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg4.png",
              "text": "It’s an amazing place, isn't? As you can see, these Roman ruins are a glimpse into the past",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg4.png",
              "text": "with old houses, streets, and walls telling the story of the ancient romanian civilization in Tipaza",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg4.png",
              "text": "Was that everything for the ruins ?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg4.png",
              "text": "of course not we still have the Roman theater",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg5.png",
              "text": "it is a large stone theater where people used to watch plays and performances.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg5.png",
              "text": "OWW nice i like this THEATER!! There is so much history in Tipaza!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg5.png",
              "text": "bring the camera let me take a photo here!! ",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "What’s that building over there",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "Ah, that’s the Tipaza Archaeological Museum! It was built in 1955 and has a lot of cool things from the past",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "It’s full of objects that show how people lived a long time ago. Want to take a look inside?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "Definitly! What can we find there?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "Inside, you’ll see things like ancient mosaics. One of the most famous ones is the Mosaic of the Captives",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "The museum has glass objects statues, coins, and jewelry too. It’s a great way to learn about the city’s history",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "I can’t wait to check this out !!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "$userName are you ready for a new mini game?? Let’s go!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg6.png",
              "text": "See you later Mehdi !!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "This is the Tipaza Port. It’s a charming spot by the sea, where fishermen once brought fresh fish",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "and now it's a perfect place to relax and enjoy the peaceful views.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "Woah Fish!! I love fish",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "Tipaza is known for its delicious seafood, come here lets catch some fish !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "Woah, i want to eat fish each day! I am gonna live in tipaza",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg7.png",
              "text": "speaking of food, let’s take a seat at the beach, and I will tell you about all the delicious dishes here",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "In general, The  northern region is known by its traditional food and not only seafood",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "People here eat couscous on fridays ,it is a dish made with tiny grains and vegetables",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "There is also chorba which is a spicy soup made with vegtables and meat",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "there is also the chekchouka, it is very delicious, colorful, tasty and full of vitamins !!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "WOW , that’s so Yummy !!!!!!!!!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "but.... Do you know what time it is ?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure2/bg8.png",
              "text": "It is gaming time... See you later Mehdi",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            
          ],
          onDialogueEnd: () {
            //WHEN DIALOGUE ENDS DO SMTHN
          },
        ),

          Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.02),
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
                        title: "Back to Main Menu?",
                        message: "Are you sure you want to go back? Your progress will be lost.",
                        iconPath: "assets/icons/fennec/fennec_settings_icon.png",
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
                            onTap: () => Navigator.pop(context), // Just close dialog
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
                SizedBox(width: screenWidth * 0.01), // Spacing

                // Pause Button
                Material(
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      Navigator.of(context).pop();
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
        ]
      ),
    );
  }
}


