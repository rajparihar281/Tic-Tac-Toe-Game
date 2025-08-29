import 'package:flutter/material.dart';
import '../models/game_state.dart';

class GameCell extends StatelessWidget {
  final int index;
  final GameState gameState;
  final Function(int) onTap;
  final Animation<double> winAnimation;
  final Animation<double> scaleAnimation;

  const GameCell({
    super.key,
    required this.index,
    required this.gameState,
    required this.onTap,
    required this.winAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    bool isWinningCell = gameState.winningCells.contains(index);

    return AnimatedBuilder(
      animation: gameState.cellAnimated[index] ? scaleAnimation : winAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: gameState.cellAnimated[index] && gameState.board[index] != ''
              ? scaleAnimation.value
              : (isWinningCell ? 1.0 + (winAnimation.value * 0.1) : 1.0),
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: isWinningCell
                    ? Colors.amber.withOpacity(0.3 + (winAnimation.value * 0.4))
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isWinningCell
                      ? Colors.amber.shade600
                      : Colors.grey.shade300,
                  width: isWinningCell ? 3 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: isWinningCell ? 50 : 45,
                    fontWeight: FontWeight.bold,
                    color: gameState.board[index] == 'X'
                        ? Colors.red.shade500
                        : Colors.blue.shade500,
                  ),
                  child: Text(gameState.board[index]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
