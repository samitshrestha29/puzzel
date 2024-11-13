import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bible_puzzle_game/home_page/game.dart';

class IphoneMini4 extends StatefulWidget {
  const IphoneMini4({super.key});

  @override
  _IphoneMini4State createState() => _IphoneMini4State();
}

class _IphoneMini4State extends State<IphoneMini4> {
  static const int totalLevels = 20;
  List<bool> levelCompletionStatus =
      List.generate(totalLevels, (index) => false);
  List<dynamic> levelsData = [];
  int currentLevel = 0;

  @override
  void initState() {
    super.initState();
    loadLevelData();
  }

  Future<void> loadLevelData() async {
    final String jsonString =
        await rootBundle.loadString('assets/level_data.json');
    final data = json.decode(jsonString);
    setState(() {
      levelsData = data['levels'];
    });
  }

  void completeLevel(int levelIndex) {
    setState(() {
      levelCompletionStatus[levelIndex] = true;
      if (levelIndex < totalLevels - 1) {
        currentLevel = levelIndex + 1; // Unlock next level
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/iphone_mini_2/iphone_mini_2.JPG',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: screenHeight * 0.05,
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
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.01,
                  ),
                  margin: EdgeInsets.only(top: screenHeight * 0.11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 194, 119, 5),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    'Select Level',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: totalLevels,
                    itemBuilder: (context, index) {
                      final level = index + 1;
                      final isCompleted = levelCompletionStatus[index];
                      final isCurrentLevel = index == currentLevel;
                      final isUnlocked = index <= currentLevel || isCompleted;
                      final color = isCompleted
                          ? Colors.green
                          : isCurrentLevel
                              ? Colors.blue
                              : Colors.orange;

                      return ElevatedButton(
                        onPressed: isUnlocked && index < levelsData.length
                            ? () async {
                                final isLevelCompleted = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Game(
                                      level:
                                          level, // Pass the level number here
                                      levelData: levelsData[index],
                                      onLevelComplete: () =>
                                          completeLevel(index),
                                    ),
                                  ),
                                );
                                if (isLevelCompleted == true) {
                                  completeLevel(index);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          disabledBackgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: isUnlocked
                            ? Text(
                                level.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
