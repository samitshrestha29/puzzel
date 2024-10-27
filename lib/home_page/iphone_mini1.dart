import 'package:flutter/material.dart';

class IphoneMini1 extends StatelessWidget {
  const IphoneMini1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B4BFA),
              Color(0xFF3A076C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Ads icon
                  Image.asset(
                    'assets/iphone_mini_1/ads.png',
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/iphone_mini_1/setting.png',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 0,
              child: Image(
                image: AssetImage('assets/iphone_mini_1/Group2.png'),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 1.7,
              child: const Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/iphone_mini_1/Group1.png'),
              ),
            ),
            Positioned(
              child: Image(
                fit: BoxFit.cover,
                image: const AssetImage('assets/iphone_mini_1/Group3.png'),
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.35,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/iphone_mini_1/start_button.png'),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.2,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/iphone_mini_1/share_button.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
