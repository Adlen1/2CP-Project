import 'package:flutter/material.dart';
import 'dart:math';

class JigsawPuzzle extends StatefulWidget {
  const JigsawPuzzle({super.key});

  @override
  State<JigsawPuzzle> createState() => _JigsawPuzzleState();
}

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  List<bool> part = List.generate(4, (index) => false);
  List<Offset> piecePositions = [
    Offset(50, 500), // Initial draggable positions
    Offset(150, 500),
    Offset(250, 500),
    Offset(350, 500),
  ];

  @override
  Widget build(BuildContext context) {
    double containerSize = 210;
    double pieceSize =
        containerSize / 2; // Each piece takes 25% of the container

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "assets/images/1fullImage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Semi-transparent overlay
                  Positioned.fill(
                    child: Container(color: Colors.white.withOpacity(0.5)),
                  ),

                  // 🔹 DragTargets with Distance Check
                  _buildDragTarget(0, Alignment.topLeft, 0, 0, pieceSize),
                  _buildDragTarget(
                    1,
                    Alignment.topRight,
                    pieceSize,
                    0,
                    pieceSize,
                  ),
                  _buildDragTarget(
                    2,
                    Alignment.bottomLeft,
                    0,
                    pieceSize,
                    pieceSize,
                  ),
                  _buildDragTarget(
                    3,
                    Alignment.bottomRight,
                    pieceSize,
                    pieceSize,
                    pieceSize,
                  ),

                  // 🔹 Show pieces in the correct position after being placed
                  if (part[0])
                    _buildPiece("assets/images/1part1.png", Alignment.topLeft),
                  if (part[1])
                    _buildPiece("assets/images/1part2.png", Alignment.topRight),
                  if (part[2])
                    _buildPiece(
                      "assets/images/1part3.png",
                      Alignment.bottomLeft,
                    ),
                  if (part[3])
                    _buildPiece(
                      "assets/images/1part4.png",
                      Alignment.bottomRight,
                    ),
                ],
              ),
            ),
          ),

          // 🔹 Draggable Pieces (Only show if not placed)
          for (int i = 0; i < 4; i++)
            if (!part[i])
              Positioned(
                left: piecePositions[i].dx,
                top: piecePositions[i].dy,
                child: Draggable<int>(
                  data: i,
                  feedback: Image.asset(
                    "assets/images/1part${i + 1}.png",
                    width: pieceSize,
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/images/1part${i + 1}.png",
                      width: pieceSize,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/1part${i + 1}.png",
                    width: pieceSize,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  /// Builds DragTargets with distance-based acceptance
  Widget _buildDragTarget(
    int index,
    Alignment alignment,
    double targetX,
    double targetY,
    double size,
  ) {
    return Positioned(
      left: targetX,
      top: targetY,
      child: DragTarget<int>(
        onWillAcceptWithDetails: (details) {
          int pieceIndex = details.data;
          Offset piecePosition = piecePositions[pieceIndex];

          // Calculate distance from target position
          double distance = sqrt(
            pow(piecePosition.dx - targetX, 2) +
                pow(piecePosition.dy - targetY, 2),
          );

          return pieceIndex == index &&
              distance < 100; // ✅ Correct piece & within 100 pixels
        },
        onAcceptWithDetails: (details) {
          setState(() {
            part[details.data] = true; // ✅ Mark piece as placed
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: size,
            height: size,
            color: Colors.transparent, // Target area remains invisible
          );
        },
      ),
    );
  }

  /// Displays a placed puzzle piece
  Widget _buildPiece(String imagePath, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 105,
        height: 105,
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
