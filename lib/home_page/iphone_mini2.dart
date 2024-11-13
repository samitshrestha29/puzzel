import 'package:bible_puzzle_game/home_page/iphone_mini4.dart';

import 'package:flutter/material.dart';

class IphoneMini2 extends StatelessWidget {
  const IphoneMini2({super.key});

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
          // Back Button positioned to the top-left corner
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
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.12, bottom: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 194, 119, 5),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    'Choose Bible Category',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenHeight * 0.01,
                    crossAxisSpacing: screenWidth * 0.05,
                    childAspectRatio: 2.5,
                    children: [
                      CategoryButton(
                          label: 'Comforting',
                          onPressed: () {
                            // Navigate to IphoneMini4 when "Comforting" is clicked
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const IphoneMini4()),
                            );
                          }),
                      // Other CategoryButton instances remain the same
                      const CategoryButton(label: 'Courage'),
                      const CategoryButton(label: 'Faith-In-Hard-Times'),
                      const CategoryButton(label: 'Forgiveness'),
                      const CategoryButton(label: 'Friendship'),
                      const CategoryButton(label: 'God\'s Promises'),
                      const CategoryButton(label: 'Happiness'),
                      const CategoryButton(label: 'Healing'),
                      const CategoryButton(label: 'Hope'),
                      const CategoryButton(label: 'Love'),
                      const CategoryButton(label: 'Motivational'),
                      const CategoryButton(label: 'Peace'),
                      const CategoryButton(label: 'Prayers'),
                      const CategoryButton(label: 'Protection'),
                      const CategoryButton(label: 'Thankful'),
                    ],
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

class CategoryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CategoryButton({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenHeight * 0.025;

    if (label.length > 10) {
      fontSize *= 0.80;
    }

    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: screenHeight * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = screenHeight * 0.0015
                ..color = Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.9),
                  offset: Offset(screenHeight * 0.002, screenHeight * 0.005),
                  blurRadius: screenHeight * 0.003,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
