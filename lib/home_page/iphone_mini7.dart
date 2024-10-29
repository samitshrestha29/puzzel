import 'dart:math';
import 'package:flutter/material.dart';

class IphoneMini7 extends StatelessWidget {
  const IphoneMini7({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/iphone_mini_7/iphone_mini_7.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Back Button
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
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.01,
                  ),
                  margin: EdgeInsets.only(top: screenHeight * 0.08),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Level - 1',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 149, 43, 5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.0001),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20, // Adjust spacing as needed
                  childAspectRatio:
                      3.5, // Adjust aspect ratio to control width and height ratio
                  children: const [
                    WordTile(word: "LORD"),
                    WordTile(word: "SPIRIT"),
                    WordTile(word: "JESUS"),
                    WordTile(word: "HEART"),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                height: screenHeight * 0.50,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 7.0,
                  ),
                  itemCount: 42, // 6x7 grid
                  itemBuilder: (context, index) {
                    return LetterTile(); // Generates a tile with a random letter
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.030),
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

class WordTile extends StatelessWidget {
  final String word;

  const WordTile({required this.word, super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          word,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Widget for each letter tile in the grid (generates random letters)
class LetterTile extends StatelessWidget {
  final String letter;

  LetterTile({super.key}) : letter = _generateRandomLetter();

  static String _generateRandomLetter() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return letters[random.nextInt(letters.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
