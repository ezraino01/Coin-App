// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'Login.dart';
//
// class EmailVerificationScreen extends StatefulWidget {
//   @override
//   _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
// }
//
// class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool isLoading = false;
//
//   Future<void> checkEmailVerified() async {
//     User? user = _auth.currentUser;
//     await user!.reload();
//     if (user.emailVerified) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Login(), // Change to your target screen
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Email not verified yet. Please check your email.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'A verification email has been sent to your email address. Please verify your email before continuing.',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 await checkEmailVerified();
//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               child: Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'Login.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'An email has been sent to ${user.email} for verification.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                user.sendEmailVerification();
              },
              child: Text('Resend Email'),
            ),
          ],
        ),
      ),
    );
  }
}
