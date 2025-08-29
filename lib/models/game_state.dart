class GameState {
  List<String> board;
  String currentPlayer;
  String winner;
  List<int> winningCells;
  bool gameOver;
  int xWins;
  int oWins;
  int draws;
  List<bool> cellAnimated;

  GameState({
    List<String>? board,
    this.currentPlayer = 'X',
    this.winner = '',
    List<int>? winningCells,
    this.gameOver = false,
    this.xWins = 0,
    this.oWins = 0,
    this.draws = 0,
    List<bool>? cellAnimated,
  }) : board = board ?? List.filled(9, ''),
       winningCells = winningCells ?? [],
       cellAnimated = cellAnimated ?? List.filled(9, false);

  GameState copyWith({
    List<String>? board,
    String? currentPlayer,
    String? winner,
    List<int>? winningCells,
    bool? gameOver,
    int? xWins,
    int? oWins,
    int? draws,
    List<bool>? cellAnimated,
  }) {
    return GameState(
      board: board ?? List.from(this.board),
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
      winningCells: winningCells ?? List.from(this.winningCells),
      gameOver: gameOver ?? this.gameOver,
      xWins: xWins ?? this.xWins,
      oWins: oWins ?? this.oWins,
      draws: draws ?? this.draws,
      cellAnimated: cellAnimated ?? List.from(this.cellAnimated),
    );
  }

  void reset() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = '';
    winningCells = [];
    gameOver = false;
    cellAnimated = List.filled(9, false);
  }

  void resetScore() {
    xWins = 0;
    oWins = 0;
    draws = 0;
  }
}
