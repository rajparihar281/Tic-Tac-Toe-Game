import 'package:flutter/material.dart';
import '../models/game_state.dart';
import 'game_cell.dart';

class GameBoard extends StatelessWidget {
  final GameState gameState;
  final Function(int) onCellTap;
  final Animation<double> winAnimation;
  final Animation<double> scaleAnimation;

  const GameBoard({
    super.key,
    required this.gameState,
    required this.onCellTap,
    required this.winAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GameCell(
                index: index,
                gameState: gameState,
                onTap: onCellTap,
                winAnimation: winAnimation,
                scaleAnimation: scaleAnimation,
              );
            },
          ),
        ),
      ),
    );
  }
}
