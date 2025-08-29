import '../models/game_state.dart';

class GameLogic {
  static const List<List<int>> _winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6], // Diagonals
  ];

  static bool makeMove(GameState gameState, int index) {
    if (gameState.board[index] != '' || gameState.gameOver) {
      return false;
    }

    gameState.board[index] = gameState.currentPlayer;
    gameState.cellAnimated[index] = true;

    return true;
  }

  static bool checkWinner(GameState gameState) {
    // Check for winning patterns
    for (List<int> pattern in _winPatterns) {
      if (gameState.board[pattern[0]] != '' &&
          gameState.board[pattern[0]] == gameState.board[pattern[1]] &&
          gameState.board[pattern[1]] == gameState.board[pattern[2]]) {
        gameState.winner = gameState.board[pattern[0]];
        gameState.winningCells = pattern;
        gameState.gameOver = true;

        // Update score
        if (gameState.winner == 'X') {
          gameState.xWins++;
        } else {
          gameState.oWins++;
        }

        return true;
      }
    }

    // Check for draw
    if (!gameState.board.contains('')) {
      gameState.winner = 'Draw';
      gameState.gameOver = true;
      gameState.draws++;
      return true;
    }

    return false;
  }

  static void switchPlayer(GameState gameState) {
    gameState.currentPlayer = gameState.currentPlayer == 'X' ? 'O' : 'X';
  }
}
