import 'package:cryptomania/Guest_page.dart';
import 'package:cryptomania/Login.dart';
import 'package:cryptomania/SignUp.dart';
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
              //1
              Padding(
                padding: const EdgeInsets.only(top: 85),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/img_3.png'),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                    Text(
                      'Welcome to Bee \n CoinCap',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Text(
                        'There\'s something for everyone to enjoy\n with bee CoinCap'),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        _pageController.animateToPage(2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        height: 50,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //2
              Column(
                children: [
                  Container(
                    height: height * 1,
                    width: double.infinity,
                    color: Colors.green,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Text(
                            'Your crypto journey \nis about to get better\n with the Bee App',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Text(
                          'There\'s something for everyone to enjoy\n with bee CoinCap',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: height * 0.15,
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage('assets/images/img_1.png'),
                        ),
                        SizedBox(
                          height: height * 0.115,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Container(
                            height: 50,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
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
                count: 2, // Number of pages
                effect: WormEffect(
                  dotHeight: 7,
                  dotWidth: 20,
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
