import 'package:flutter/material.dart';

class IphoneMini4 extends StatelessWidget {
  const IphoneMini4({super.key});

  @override
  Widget build(BuildContext context) {
    const int totalLevels = 40;
    const int unlockedLevels = 8;
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

          // Fixed Header and Scrollable Grid
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
              // SizedBox to create space below the header
              SizedBox(height: screenHeight * 0.15),

              // Scrollable Grid for Levels
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Number of buttons per row
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: totalLevels,
                    itemBuilder: (context, index) {
                      final level = index + 1;
                      bool isUnlocked = level <= unlockedLevels;

                      return ElevatedButton(
                        onPressed:
                            isUnlocked ? () {} : null, // Disable if locked
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .orange, // Orange background for all buttons
                          disabledBackgroundColor:
                              Colors.orange, // Orange even if disabled
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
