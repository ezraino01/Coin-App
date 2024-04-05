import 'package:flutter/material.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: 200,
        width: double.infinity,
        color: Colors.yellow,


      ),
    );
  }
}
