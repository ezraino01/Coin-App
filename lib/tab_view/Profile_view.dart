import 'package:cryptomania/SignUp.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Users users;

  const Profile({Key? key, required this.users}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // Extract username

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome ${widget.users!.name}',
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ), // Display username
            Stack(
              children: [
                Container(
                  height: height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
