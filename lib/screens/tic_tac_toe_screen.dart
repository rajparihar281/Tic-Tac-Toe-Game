import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/game_state.dart';
import '../services/game_logic.dart';
import '../widgets/game_board.dart';
import '../widgets/score_card.dart';
import '../widgets/player_status.dart';
import '../widgets/control_button.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen>
    with TickerProviderStateMixin {
  late GameState gameState;

  // Animation controllers
  late AnimationController _winAnimationController;
  late AnimationController _cellAnimationController;
  late Animation<double> _winAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    gameState = GameState();

    _winAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _cellAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _winAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _winAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cellAnimationController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _winAnimationController.dispose();
    _cellAnimationController.dispose();
    super.dispose();
  }

  void _makeMove(int index) {
    if (GameLogic.makeMove(gameState, index)) {
      setState(() {});

      // Trigger cell animation
      _cellAnimationController.reset();
      _cellAnimationController.forward();

      // Add haptic feedback
      HapticFeedback.lightImpact();

      bool gameEnded = GameLogic.checkWinner(gameState);

      if (gameEnded) {
        if (gameState.winner != 'Draw') {
          // Trigger win animation
          _winAnimationController.forward();
          HapticFeedback.heavyImpact();
        } else {
          HapticFeedback.mediumImpact();
        }
      } else {
        GameLogic.switchPlayer(gameState);
      }

      setState(() {});
    }
  }

  void _resetGame() {
    setState(() {
      gameState.reset();
    });

    _winAnimationController.reset();
    _cellAnimationController.reset();
    HapticFeedback.selectionClick();
  }

  void _resetScore() {
    setState(() {
      gameState.resetScore();
    });
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade500,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with scores
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScoreCard(
                      label: 'X',
                      score: gameState.xWins,
                      color: Colors.red.shade400,
                    ),
                    ScoreCard(
                      label: 'Draws',
                      score: gameState.draws,
                      color: Colors.grey.shade600,
                    ),
                    ScoreCard(
                      label: 'O',
                      score: gameState.oWins,
                      color: Colors.blue.shade400,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Current player or winner display
              PlayerStatus(gameState: gameState),

              SizedBox(height: 30),

              // Game Board
              Expanded(
                child: Center(
                  child: GameBoard(
                    gameState: gameState,
                    onCellTap: _makeMove,
                    winAnimation: _winAnimation,
                    scaleAnimation: _scaleAnimation,
                  ),
                ),
              ),

              // Control buttons
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ControlButton(
                      text: 'New Game',
                      icon: Icons.refresh,
                      onPressed: _resetGame,
                      color: Colors.green.shade400,
                    ),
                    ControlButton(
                      text: 'Reset Score',
                      icon: Icons.clear_all,
                      onPressed: _resetScore,
                      color: Colors.orange.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
