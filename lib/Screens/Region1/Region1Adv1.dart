import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';



class Region1Adv1 extends StatefulWidget {
  final int profileNbr;
  final String region;
  final int adventure;

  const Region1Adv1({
    Key? key,
    required this.profileNbr,
    required this.region , 
    required this.adventure , 
  }) : super(key: key);

  @override
  _Region1Adv1State createState() => _Region1Adv1State();
}

class _Region1Adv1State extends State<Region1Adv1> with SingleTickerProviderStateMixin {

  bool lockview = false ;
  final _dialogueBoxKey = GlobalKey<_DialogueBoxState>();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

        DialogueBox(
          key: _dialogueBoxKey,
          lockview: lockview,
          dialogues: [
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "Welcome, young explorer, to the first adventure of our journey!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "Today, we’re heading to the heart of Algeria… The amazing city of Algiers!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "it’s the capital and I am sure it’s full of surprises!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "I’ve heard that Algiers is a city by the sea, with white buildings that shine under the sun.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "speaking of the buildings… I think we are near the place of my old friend Mehdi",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg1.jpg",
              "text": "Can you help me find him ?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "ACE ! My old friend! It’s been a while! Still sniffing out new adventures, huh?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "You know me! And this time, I’m not going alone… I’ve brought a young explorer with me!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "Curious, brave… and ready to uncover all the secrets of the northern region.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "Oh yes… When I was your age, I used to travel with my family through this beautiful region.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "You can say I know  every corner of it! That’s why I decided to join you on this adventure.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "But enough talking… It’s time to dive into the adventure!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "Together, we’ll embark on two exciting adventures, exploring worlds filled with games, fun challenges, and amazing surprises!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "Cool, see? I told you, you wouldn’t be bored!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "Oh, that’s for sure! Grab your backpack! and let’s dive in ",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "excelent .. now the real adventure starts in its oldest part… the Casbah.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg2.jpg",
              "text": "The Casbah? I’ve heared about it from my grandfather .Can we see it in depth?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "It’s a city that stands between the present and the past",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "tiny streets, old houses with colorful doors here every stone tells a story from Algeria’s past.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "The past of Algeria?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "Yes, as you can see, this city was at the heart of the fight against the French enemy,",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "they wanted to erase Algerian culture and traditions. That’s why we, as Algerians, are committed to preserve them today.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "then what traditions it holds here?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "Oh! It stands for the different dishes and clothes that show our identity.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "Here in Algiers, for example, men wear the Djellaba and women wear the Karakou or el Hayek .",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "Want to see more? Let’s play a puzzle to explore it together!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg3.jpg",
              "text": "Well done , now let’s Move near by another location !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg4.jpg",
              "text": "Ow, what a big monument it stands for what exactly  ,  is it  history?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg4.jpg",
              "text": "Bingo! This monument is called the Martyrs’ Memorial. ",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg4.jpg",
              "text": "It was built in 1982 to honor the memory of Algeria’s brave heros who fought for our independence.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg4.jpg",
              "text": "It stands high on a hill in Algiers and looks like three giant palm leaves. From up there, you can see the whole city.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg4.jpg",
              "text": "Wow,I heared that Algiers is named the green wilaya ,any landscape to discover?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "True,a beautiful green space is waiting for us , let’s get there",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "Here,whrer’s the secret of the algerien nature is inveiled,It’s a kingdom of plants and animals",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "Imagine a giant forest so tall that almost touch the sky,with colorful flowers and palms!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "AWESOME !!!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "Next door,We can find a ZOO that holds different animals : Lions , tigers , playful monkeys …",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "I may find my cousin there !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "I know it’s a lot of interesting information,let’s get now into a memory Game ...",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "It looks like the stories of Algiers are not mystery to you anymore…",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "But be careful this city isn’t just about the past and memories! today, Algiers is also modern and full of life!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "And to show you,Let’s head to the majestic Great Mosque of Algiers!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg5.jpg",
              "text": "Modern Algiers, here we come!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": " heard the tower of this mosque is so tall… do you think I could spot my home all the way from the desert?",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "Haha! If anyone can spot his home from up there, it’s you, ACE !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "It’s the biggest mosque in Africa and one of the largest in the world!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "But seriously, here we are at the Great Mosque of Algiers built in 2020",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "It’s the biggest mosque in Africa and one of the largest one in the world!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "The prayer hall is huge therefore many people come here not just to pray, but also to learn and explore.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "come on ... let’s pick the appropriate outfit for the mosque ",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "good job !  now u see that tall tower? It’s called a minaret, From the top, you can see the city, the sea and far beyond.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "There’s even a library, a museum, and beautiful gardens all around. It’s a peaceful and special place for everyone.",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "Wow! The difference between the old and new buildings is incredible!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/fennec_dialogue_box.png",
              "speaker" : "fennec"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "Exactly! They say the fennec has super watchful eyes, I can confirm that…",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "Let’s see if our young explorer’s eyes are just as powerful as yours !",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "I think a fun game of Spot the Differences will put your observation skills to the test. Ready? Let’s go!",
              "speakerIcon1": "assets/icons/region1/adventure1/fennec.png",
              "speakerIcon2": "assets/icons/region1/adventure1/mehdi.png",
              "textBoxIcon": "assets/icons/region1/adventure1/mehdi_dialogue_box.png",
              "speaker" : "mehdi"
            },
            {
              "bg" : "assets/backgrounds/region1/adventure1/bg6.jpg",
              "text": "Let’s GOOO !!",
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



class DialogueBox extends StatefulWidget {
  final List<Map<String, String>> dialogues;
  final VoidCallback? onDialogueEnd;
  final GlobalKey<_DialogueBoxState>? key;
  final bool lockview ;

  const DialogueBox({this.key, required this.dialogues, this.onDialogueEnd , required this.lockview}) : super(key: key);

  @override
  _DialogueBoxState createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  int currentDialogueIndex = 0;
  String displayedText = "";
  int charIndex = 0;
  Timer? timer;
  bool isTyping = false;
  bool isVisible = true;
  double boxWidth = 0.25;
  double boxHeight = 0.15;
  double boxTop = 0.8;
  double boxLeft = 0.65;
  String boxText = "Default Text";



  @override
  void initState() {
    super.initState();
    startTyping();
  }

  void startTyping() {
    setState(() {
      displayedText = "";
      charIndex = 0;
      isTyping = true;
    });

    timer = Timer.periodic(Duration(milliseconds: 40), (Timer t) {
      if (charIndex < widget.dialogues[currentDialogueIndex]["text"]!.length) {
        setState(() {
          displayedText += widget.dialogues[currentDialogueIndex]["text"]![charIndex];
          charIndex++;
        });
      } else {
        t.cancel();
        setState(() {
          isTyping = false;
        });
      }
    });
  }

  void proceedToNextDialogue() {
    if (isTyping) {
      setState(() {
        displayedText = widget.dialogues[currentDialogueIndex]["text"]!;
        isTyping = false;
      });
      timer?.cancel();
    } else {
      switch (currentDialogueIndex) {
        case var i when i == widget.dialogues.length - 1:
          widget.onDialogueEnd?.call(); 
          return;

        case 16 : {
          setState(() {
            currentDialogueIndex++; 
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Casbah";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isVisible = true; 
              
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        //case 19: {}
        //case 6 {}
        case 26: {
          setState(() {
            currentDialogueIndex++; 
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Martyrs’ Memorial";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        case 31: {
          setState(() {
            currentDialogueIndex++; 
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Hamma gardens";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        ///case 29: {}
        ///case 33: {}
        case 42: {setState(() {
            currentDialogueIndex++; 
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "Algiers great mosque";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;}
        //case 45: {}
        ///case 48: {}
        ///case 54: {}
        //case 62: {}
        ///case 70: {}
        default:
          setState(() {
            currentDialogueIndex++;
          });
          startTyping();
      }
    }
  }

  void proceedToPreviousDialogue() {
    if (currentDialogueIndex > 0) {
      switch (currentDialogueIndex) {
        case 17 : {
          setState(() {
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Casbah";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isVisible = true; 
              currentDialogueIndex--; 
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        case 27: {
          setState(() {
            
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Martyrs’ Memorial";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              currentDialogueIndex--; 
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        case 32: {
          setState(() {
            
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "The Hamma gardens";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              currentDialogueIndex--; 
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;
        }
        case 43: {setState(() {
             
            isVisible = false;
            boxWidth = 0.25;
            boxHeight = 0.15;
            boxTop = 0.8;
            boxLeft = 0.65;
            boxText = "Algiers great mosque";
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              currentDialogueIndex--;
              isVisible = true; 
            });
            startTyping(); // Restart the typing effect
          });
          break;}
        default:
          setState(() {
            currentDialogueIndex--;
          });
          startTyping();
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;



  String? speakerIcon1 = widget.dialogues[currentDialogueIndex]["speakerIcon1"];
  String? speakerIcon2 = widget.dialogues[currentDialogueIndex]["speakerIcon2"];

  String? speaker = widget.dialogues[currentDialogueIndex]["speaker"];
  String bg = widget.dialogues[currentDialogueIndex]["bg"] ?? "assets/backgrounds/region1/adventure1/bg1.jpg";


  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Positioned.fill(
        child: Image.asset(
          bg,
          fit: BoxFit.fill,
        ),
      ),

      if(isVisible && !widget.lockview)
      Positioned(
        left: (speakerIcon1 != null && speaker != null && speakerIcon1.contains(speaker)) 
          ? screenWidth * 0.12
          : screenWidth * 0.08,

        bottom: screenHeight * 0.1,
        child: Stack(
          alignment: Alignment.center, // Centers everything in the stack
          children: [
            // Dialogue Box Background
            Image.asset(
              widget.dialogues[currentDialogueIndex]["textBoxIcon"]!,
              width:  screenWidth * 0.75,
              height: screenHeight * 0.3,
            ),

            // Text Container
            Container(
              width: screenWidth * 0.7, // Ensures text doesn't overflow
              padding: EdgeInsets.fromLTRB(
                (speakerIcon1 != null && speaker != null && speakerIcon1.contains(speaker)) 
                  ? screenWidth * 0.05 // Shift text to the right
                  : screenWidth * 0.1, // Default left padding
                screenHeight * 0.015, 
                (speakerIcon1 != null && speaker != null && speakerIcon1.contains(speaker)) 
                  ? screenWidth * 0.11  // Default right padding
                  : screenWidth * 0.05, // Shift text to the left
                screenHeight * 0.015
              ), 
              child: Text(
                displayedText,
                style: TextStyle(
                  fontFamily: 'Fredoka2',
                  fontSize: screenWidth * 0.024,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56351E),
                ),
                textAlign: TextAlign.center, // Center text inside the container
                softWrap: true, // Allows text wrapping
              ),
            ),
          ],
        ),
      ),

      if(isVisible && !widget.lockview)
      if (speakerIcon1 != null) 
      Positioned(
        left: screenWidth * 0.68,
        bottom: screenHeight * 0.05,
        child: Image.asset(
          widget.dialogues[currentDialogueIndex]["speakerIcon1"]!,
          width: screenWidth * 0.45, 
          height: screenHeight * 0.45,
        ),
      ),

      if(isVisible && !widget.lockview)
      if (speakerIcon2 != null) 
      Positioned(
        left: -screenWidth * 0.22,
        bottom: screenHeight * 0.02,
        child: Image.asset(
          widget.dialogues[currentDialogueIndex]["speakerIcon2"]!,
          width: screenWidth * 0.55, 
          height: screenHeight * 0.55,
        ),
      ),

      if (!isVisible && !widget.lockview)
              Positioned(
                top: screenHeight * boxTop ,
                left: screenWidth * boxLeft ,
                child: Container(
                  width: screenWidth * boxWidth ,
                  height: screenHeight * boxHeight ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                     border: Border.all(
                      color: Color(0xFFFFCB7C),  // Couleur de la bordure
                      width: 3,  // Épaisseur de la bordure
                    ),
                  ),
                  
                  child: Center(
                    child: Text(
                      boxText ,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: screenWidth * 0.024,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF56351E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

      if(!widget.lockview && isVisible)
      Stack(
          children: [
            Positioned(
              left: screenWidth * 0.18, 
              bottom: - screenHeight * 0.03, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedGameButton(
                    "assets/icons/region1/adventure1/back_button.png",
                    screenWidth * 0.2,
                    screenHeight * 0.2,
                    screenWidth * 0.1,
                    screenHeight * 0.1,
                    onTap: () {
                      proceedToPreviousDialogue();
                    },
                  ),
                  AnimatedGameButton(
                    "assets/icons/region1/adventure1/skip_button.png",
                    screenWidth * 0.2,
                    screenHeight * 0.2,
                    screenWidth * 0.1,
                    screenHeight * 0.1,
                  ),
                  AnimatedGameButton(
                    "assets/icons/region1/adventure1/next_button.png",
                    screenWidth * 0.2,
                    screenHeight * 0.2,
                    screenWidth * 0.1,
                    screenHeight * 0.1,
                    onTap: () {
                      proceedToNextDialogue();
                    },
                  ),
                ],
              ),
            ),

            
          ],
        ),
    ],
  );
}
}