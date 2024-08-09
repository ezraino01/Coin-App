import 'package:cryptomania/Login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              // Page 1
              Stack(
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_3.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Bee',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          'CoinCap',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Page 2
              Stack(
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          'Track Your',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          'Cryptocurrency',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Page 3
              Stack(
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          'Stay Updated',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          'With Latest Trends',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.5,
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  'Continue as a guest',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.green[100]),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.person_2_rounded,
                              color: Colors.green[100],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Dots Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3, // Number of pages
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
