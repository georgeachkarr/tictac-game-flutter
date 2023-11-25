import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final String player1;
  final String player2;

  const Game({Key? key, required this.player1, required this.player2})
      : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  // Initialize game
  void _initializeGame() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  // Reset game
  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  // Check for a winner
  void _checkWinner(int row, int col) {
    if (_checkRow(row) || _checkColumn(col) || _checkDiagonals()) {
      _winner = _currentPlayer;
      _gameOver = true;
    }
  }

  bool _checkRow(int row) {
    return _board[row].every((cell) => cell == _currentPlayer);
  }

  bool _checkColumn(int col) {
    return _board.every((row) => row[col] == _currentPlayer);
  }

  bool _checkDiagonals() {
    return (_board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) ||
        (_board[0][2] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][0] == _currentPlayer);
  }

  // Make a move
  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;
      _checkWinner(row, col);

      // Switch player
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      // Check for a tie
      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "It's a Tie";
      }

      // Show dialog if there's a winner or a tie
      if (_winner != "") {
        _showResultDialog();
      }
    });
  }

  // Show result dialog
  void _showResultDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      btnOkText: "Play Again",
      title: _winner == "X"
          ? "${widget.player1} Won!"
          : _winner == "O"
          ? "${widget.player2} Won!"
          : "It's a Tie",
      btnOkOnPress: () {
        _resetGame();
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          const SizedBox(height: 70),
          SizedBox(
            height: 400,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Turn:",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _currentPlayer == "X"
                          ? "${widget.player1} ($_currentPlayer)"
                          : "${widget.player2} ($_currentPlayer)",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _currentPlayer == "X"
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(5),
                  child: GridView.builder(
                    itemCount: 9,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return GestureDetector(
                        onTap: () => _makeMove(row, col),
                        child: Container(

                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _board[row][col],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: _board[row][col] == "X"
                                    ? const Color(0xFFE25041)
                                    : const Color(0xFF1CBD9E),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
