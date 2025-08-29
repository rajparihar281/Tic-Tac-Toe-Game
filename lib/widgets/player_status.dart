import 'package:flutter/material.dart';
import '../models/game_state.dart';

class PlayerStatus extends StatelessWidget {
  final GameState gameState;

  const PlayerStatus({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: gameState.gameOver
            ? (gameState.winner == 'Draw' ? Colors.orange : Colors.green)
            : (gameState.currentPlayer == 'X'
                  ? Colors.red.shade400
                  : Colors.blue.shade400),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            gameState.gameOver
                ? (gameState.winner == 'Draw'
                      ? Icons.handshake
                      : Icons.emoji_events)
                : Icons.person,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 10),
          Text(
            gameState.gameOver
                ? (gameState.winner == 'Draw'
                      ? 'It\'s a Draw!'
                      : 'Player ${gameState.winner} Wins!')
                : 'Player ${gameState.currentPlayer}\'s Turn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
