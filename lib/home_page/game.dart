import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final dynamic levelData; // Data for the current level
  final int level;
  final VoidCallback onLevelComplete; // Callback for level completion

  const Game({
    super.key,
    required this.levelData,
    required this.onLevelComplete,
    required this.level,
  });

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> words = [];
  List<List<String>> grid = [];
  List<String> foundWords = [];
  String currentSelection = "";
  Offset? startPoint, endPoint;
  List<Offset> selectedIndices = [];
  final Color correctColor = Colors.green;
  Map<Offset, Color> cellColors = {};
  List<Offset> permanentIndices = [];
  List<Offset> permanentLinesStartEnd = [];
  bool showLine = false;

  @override
  void initState() {
    super.initState();
    initializeLevel();
  }

  void initializeLevel() {
    words = List<String>.from(widget.levelData['words']);
    grid = List<List<String>>.from(
        widget.levelData['grid'].map((row) => List<String>.from(row)));
  }

  void startSelection(int row, int col) {
    setState(() {
      selectedIndices = [Offset(row.toDouble(), col.toDouble())];
      currentSelection = grid[row][col];
      startPoint = Offset(col.toDouble(), row.toDouble());
      endPoint = startPoint;
      showLine = true;
      if (!permanentIndices.contains(Offset(row.toDouble(), col.toDouble()))) {
        cellColors.clear();
        cellColors[Offset(row.toDouble(), col.toDouble())] = Colors.blue;
      }
    });
  }

  void updateSelection(int row, int col) {
    row = row.clamp(0, grid.length - 1);
    col = col.clamp(0, grid.length - 1);

    if (startPoint == null) return;

    int startRow = startPoint!.dy.toInt();
    int startCol = startPoint!.dx.toInt();

    int deltaRow = row - startRow;
    int deltaCol = col - startCol;

    if (deltaRow.abs() == deltaCol.abs() || deltaRow == 0 || deltaCol == 0) {
      List<Offset> newSelectedIndices = [];
      String newSelection = "";
      int stepRow = deltaRow.sign;
      int stepCol = deltaCol.sign;
      int r = startRow, c = startCol;

      while (r != row + stepRow || c != col + stepCol) {
        newSelectedIndices.add(Offset(r.toDouble(), c.toDouble()));
        newSelection += grid[r][c];
        r += stepRow;
        c += stepCol;
      }

      setState(() {
        endPoint = Offset(col.toDouble(), row.toDouble());
        selectedIndices = newSelectedIndices;
        currentSelection = newSelection;

        if (!permanentIndices.any((p) => selectedIndices.contains(p))) {
          cellColors.clear();
          for (var pos in newSelectedIndices) {
            cellColors[pos] = Colors.green;
          }
        }
      });
    }
  }

  void endSelection() {
    setState(() {
      if (words.contains(currentSelection) &&
          !foundWords.contains(currentSelection)) {
        foundWords.add(currentSelection);
        for (var pos in selectedIndices) {
          permanentIndices.add(pos);
          cellColors[pos] = correctColor;
        }
        permanentLinesStartEnd.add(startPoint!);
        permanentLinesStartEnd.add(endPoint!);
        showLine = true;

        if (foundWords.length == words.length) {
          widget.onLevelComplete();
          _showCompletionDialog();
        }
      } else {
        selectedIndices.clear();
        currentSelection = "";
        cellColors.clear();
        showLine = false;
      }
      startPoint = null;
      endPoint = null;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            'Congratulations!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'You’ve found all the words!',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(true); // Return to level selection
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double cellSize = MediaQuery.of(context).size.width / grid.length;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/iphone_mini_7/iphone_mini_7.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: screenHeight * 0.08,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Image(
                image: AssetImage('assets/iphone_mini_2/back_button.png'),
                height: 50,
                width: 30,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                margin: EdgeInsets.only(top: screenHeight * 0.10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Level-${widget.level}',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 90, 26, 3),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3.5,
                  children: words.map((word) {
                    bool isFound = foundWords.contains(word);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isFound ? correctColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          word,
                          style: TextStyle(
                            color: isFound ? Colors.black : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Current Selection: $currentSelection',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onPanStart: (details) {
                        final row =
                            (details.localPosition.dy ~/ cellSize).toInt();
                        final col =
                            (details.localPosition.dx ~/ cellSize).toInt();
                        if (row >= 0 &&
                            row < grid.length &&
                            col >= 0 &&
                            col < grid.length) {
                          startSelection(row, col);
                        }
                      },
                      onPanUpdate: (details) {
                        final row =
                            (details.localPosition.dy ~/ cellSize).toInt();
                        final col =
                            (details.localPosition.dx ~/ cellSize).toInt();
                        if (row >= 0 &&
                            row < grid.length &&
                            col >= 0 &&
                            col < grid.length) {
                          updateSelection(row, col);
                        }
                      },
                      onPanEnd: (_) => endSelection(),
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(
                                constraints.maxWidth, constraints.maxHeight),
                            painter: SelectionLinePainter(
                              startPoint,
                              endPoint,
                              cellSize,
                              correctColor,
                              showLine,
                              permanentLinesStartEnd,
                            ),
                          ),
                          GridView.builder(
                            padding: const EdgeInsets.all(2.0),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: grid.length,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                            ),
                            itemCount: grid.length * grid.length,
                            itemBuilder: (context, index) {
                              int row = index ~/ grid.length;
                              int col = index % grid.length;
                              Offset pos =
                                  Offset(row.toDouble(), col.toDouble());
                              Color cellColor = cellColors[pos] ?? Colors.white;
                              if (permanentIndices.contains(pos)) {
                                cellColor = correctColor;
                              }
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: cellColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  grid[row][col],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenHeight * 0.03,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.030,
                    vertical: screenHeight * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/iphone_mini_7/shuffle.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/iphone_mini_7/idea.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectionLinePainter extends CustomPainter {
  final Offset? startPoint;
  final Offset? endPoint;
  final double cellSize;
  final Color color;
  final bool showLine;
  final List<Offset> permanentLinesStartEnd;

  SelectionLinePainter(
    this.startPoint,
    this.endPoint,
    this.cellSize,
    this.color,
    this.showLine,
    this.permanentLinesStartEnd,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    if (showLine && startPoint != null && endPoint != null) {
      canvas.drawLine(
          Offset(startPoint!.dx * cellSize + cellSize / 2,
              startPoint!.dy * cellSize + cellSize / 2),
          Offset(endPoint!.dx * cellSize + cellSize / 2,
              endPoint!.dy * cellSize + cellSize / 2),
          paint);
    }

    for (int i = 0; i < permanentLinesStartEnd.length; i += 2) {
      final start = permanentLinesStartEnd[i];
      final end = permanentLinesStartEnd[i + 1];
      canvas.drawLine(
        Offset(start.dx * cellSize + cellSize / 2,
            start.dy * cellSize + cellSize / 2),
        Offset(
            end.dx * cellSize + cellSize / 2, end.dy * cellSize + cellSize / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
