import 'package:bible_puzzle_game/home_page/iphone_mini2.dart';
import 'package:flutter/material.dart';

class IphoneMini1 extends StatelessWidget {
  const IphoneMini1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Stack(
              children: [
                Image.asset(
                  'assets/iphone_mini_1/iphone_mini_1.JPG',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 1.8,
                  left: MediaQuery.of(context).size.width / 12,
                  child: const Image(
                    image: AssetImage('assets/iphone_mini_1/Group1.png'),
                  ),
                ),
                Positioned(
                  top: screenHeight / 15,
                  left: screenwidth / 50,
                  child: Image.asset(
                    'assets/iphone_mini_1/ads.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                Positioned(
                  top: screenHeight / 15,
                  right: screenwidth / 30,
                  child: Image.asset(
                    'assets/iphone_mini_1/setting.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.40,
                  left: MediaQuery.of(context).size.width / 3.5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IphoneMini2(),
                          ));
                    },
                    child: const Image(
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/iphone_mini_1/start_button.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.2,
                  left: MediaQuery.of(context).size.width / 3.5,
                  child: const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/iphone_mini_1/share_button.png'),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
