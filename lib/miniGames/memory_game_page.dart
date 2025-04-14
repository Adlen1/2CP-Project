import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:project_2cp_eq11/miniGames/logic.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:audioplayers/audioplayers.dart';

class MemoryGamePage extends StatefulWidget {
  final int profileNbb;
  final int mode;
  final List<String> cardImages;
  final int level;
  const MemoryGamePage({
    super.key,
    required this.mode,
    required this.cardImages,
    required this.level,
    required this.profileNbb,
  });

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage>
    with TickerProviderStateMixin {
  late List<Map<String, dynamic>> cards;
  Map<int, bool> revealedCards = {}; // Tracks revealed cards
  int? firstSelectedIndex;
  int? secondSelectedIndex;
  bool canTap = true;
  int _seconds = 0;
  int _matchedPairs = 0;
  Timer? _timer;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final AudioPlayer _flipPlayer = AudioPlayer();
  bool soundF = true;
  bool alreadyPushed = false;

  @override
  void initState() {
    super.initState();
    _initializeCards();
    _startTimer();
    soundF = GameLogic.sfx(context, widget.profileNbb);
    _flipPlayer.setSource(AssetSource('audios/minigames/flipcard.mp3'));
  }

  Future<void> _playFlipSound() async {
    try {
      await _flipPlayer.stop();
      await _flipPlayer.play(AssetSource('audios/minigames/flipcard.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing flip sound: $e\x1B[0m');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _initializeCards() {
    List<String> selectedImages = widget.cardImages.sublist(0, widget.mode);
    cards =
        (selectedImages + selectedImages)
            .map((image) => {"image": image, "matched": false})
            .toList();
    cards.shuffle(Random());

    _controllers = List.generate(cards.length, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _animations =
        _controllers.map((controller) {
          return Tween<double>(begin: 0, end: pi).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          );
        }).toList();

    setState(() {
      revealedCards.clear();
      firstSelectedIndex = null;
      secondSelectedIndex = null;
      canTap = false;
    });

    // Flip all cards face-up at the start
    for (var controller in _controllers) {
      controller.forward();
    }

    // After 2 seconds, flip them back
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        for (var controller in _controllers) {
          controller.reverse();
        }
        setState(() {
          revealedCards.clear();
          canTap = true;
        });
      }
    });
  }

  void _onCardTap(int index) {
    if (!canTap || revealedCards[index] == true || cards[index]["matched"]) {
      return;
    }

    setState(() {
      revealedCards[index] = true;
    });
    if (soundF) {
      _playFlipSound();
    }
    _controllers[index].forward(); // Flip the tapped card

    if (firstSelectedIndex == null) {
      firstSelectedIndex = index;
    } else {
      secondSelectedIndex = index;
      canTap = false;

      Future.delayed(Duration(milliseconds: 700), () {
        if (cards[firstSelectedIndex!]["image"] ==
            cards[secondSelectedIndex!]["image"]) {
          setState(() {
            cards[firstSelectedIndex!]["matched"] = true;
            cards[secondSelectedIndex!]["matched"] = true;
          });
          _matchedPairs++;

          if (_matchedPairs == widget.mode) {
            _stopTimer(); // Stop timer
            Future.delayed(Duration(seconds: 2), () {
              // Short delay for UX
              if (mounted && alreadyPushed == false) {
                alreadyPushed = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MiniGamesResultsPage(
                          profileNbr: widget.profileNbb,
                          level: widget.level,
                          minigameType: "Memory",
                          time: _seconds,
                        ),
                  ),
                );
              }
            });
          }
        } else {
          _controllers[firstSelectedIndex!].reverse();
          _controllers[secondSelectedIndex!].reverse();

          setState(() {
            revealedCards.remove(firstSelectedIndex);
            revealedCards.remove(secondSelectedIndex);
          });
        }

        setState(() {
          firstSelectedIndex = null;
          secondSelectedIndex = null;
          canTap = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _stopTimer();
    for (var controller in _controllers) {
      controller.dispose();
    }
    _flipPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg5.jpg", fit: BoxFit.fill),
          ),

          // Back Button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Row(
                children: [
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
                                Navigator.pop(context); // Then go back
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
                        image: const AssetImage("assets/icons/back_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        //to add
                      },
                      child: Ink.image(
                        image: const AssetImage("assets/icons/help_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNbb,
                            ); // This will display the PauseDialog
                          },
                        );
                      },
                      child: Ink.image(
                        image: const AssetImage("assets/icons/pause_icon.png"),
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
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "MEMORY",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56351E),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF56351E),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Text(
                  GameLogic.formatTime(_seconds),
                  style: TextStyle(
                    fontFamily: 'Fredoka3',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Match Cards Game Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.mode, (index) {
                    return _buildCard(index);
                  }),
                ),
                const SizedBox(height: 10), // Space between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.mode, (index) {
                    return _buildCard(index + widget.mode);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(int index) {
    double cardWidth = widget.mode == 3 ? 140 : 135;
    double cardHeight = widget.mode == 3 ? 140 : 135;

    return GestureDetector(
      onTap: () => _onCardTap(index),
      child: AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) {
          bool isBack = _animations[index].value > pi / 2;

          return Transform(
            transform: Matrix4.rotationY(_animations[index].value)
              ..setEntry(3, 2, 0.002), // Add perspective to reduce distortion
            alignment: Alignment.center,
            child: Container(
              width: cardWidth,
              height: cardHeight,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      isBack
                          ? Border.all(
                            color:
                                cards[index]["matched"]
                                    ? Colors.green
                                    : Colors.red,
                            width: 5,
                          )
                          : null,
                  borderRadius:
                      widget.mode == 3
                          ? BorderRadius.circular(28)
                          : BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Transform(
                      alignment: Alignment.center,
                      transform:
                          isBack ? Matrix4.rotationY(pi) : Matrix4.identity(),
                      child: Image.asset(
                        isBack
                            ? cards[index]["image"] // Show front side correctly
                            : "assets/images/match/card_back.png", // Show back side
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
