import 'package:flutter/material.dart';

class IphoneMini2 extends StatelessWidget {
  const IphoneMini2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6AE36),
              Color(0xFFBB9F00),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Back button
            Positioned(
              top: screenHeight * 0.08, // Position based on screen height
              left: screenWidth * 0.05, // Position based on screen width
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Image(
                  image: AssetImage('assets/iphone_mini_2/back_button.png'),
                  height: 100,
                  width: 30,
                ),
              ),
            ),

            // Cloud image at the bottom
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/iphone_mini_2/bigcloud.png',
                width: screenWidth,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Title
            Positioned(
              top: screenHeight * 0.16, // Adjust based on screen height
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 119, 5), width: 4),
                ),
                child: Text(
                  'Choose Bible Category',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Grid of Category Buttons
            Positioned(
              top: screenHeight / 2.5,
              child: SizedBox(
                width: screenWidth * 0.9,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: screenHeight * 0.02,
                  crossAxisSpacing: screenWidth * 0.05,
                  childAspectRatio: 3,
                  children: const [
                    CategoryButton(label: 'Comforting'),
                    CategoryButton(label: 'Courage'),
                    CategoryButton(label: 'Faith-In-Hard-Times'),
                    CategoryButton(label: 'Forgiveness'),
                    CategoryButton(label: 'Friendship'),
                    CategoryButton(label: 'God\'s Promises'),
                    CategoryButton(label: 'Happiness'),
                    CategoryButton(label: 'Healing'),
                    CategoryButton(label: 'Hope'),
                    CategoryButton(label: 'Love'),
                    CategoryButton(label: 'Motivational'),
                    CategoryButton(label: 'Peace'),
                    CategoryButton(label: 'Prayers'),
                    CategoryButton(label: 'Protection'),
                    CategoryButton(label: 'Thankful'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;

  const CategoryButton({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenHeight * 0.025;

    // Reduce font size for longer labels
    if (label.length > 10) {
      fontSize *= 0.85; // adjust the scale as needed
    }

    return ElevatedButton(
      onPressed: () {},
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
          // Outline text for label
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
          // Main white text with shadow
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
