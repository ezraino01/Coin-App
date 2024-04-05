import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Positioned(
                  left: 25,
                  top: 90,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Container(
                      child: Center(
                          child: Text(
                            'Invest Today',
                            style: TextStyle(color: Colors.green),
                          )),
                      height: 30,
                      width: Width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      )
    );
  }
}
