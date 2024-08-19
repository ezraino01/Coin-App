// import 'package:cryptomania/Controller/UserController.dart';
// import 'package:cryptomania/CustomText.dart';
// import 'package:cryptomania/InterFace.dart';
// import 'package:cryptomania/SignUp.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class Login extends StatefulWidget {
//   final Users? users;
//   const Login({
//     super.key,
//     this.users,
//   });
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   SignUp signUp = SignUp();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final userController = UserController();
//   bool isLoading = true;
//   bool isToggled = true;
//   bool circularProgressIndicator = false;
//
//   final _formKey = GlobalKey<FormState>();
//   // Future<void> _launchUrl(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
//
//
//
//   Future<User?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) {
//       return null;
//     }
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//     final User? user = userCredential.user;
//
//     return user;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: Text(
//           'Login',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomText(
//                   labelText: 'email',
//                   controller: emailController,
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'field required';
//                     } else if (value.length < 5) {
//                       return 'email combination wrong';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 CustomText(
//                   obscureText: isToggled,
//                   labelText: 'password',
//                   suffixIcon: InkWell(
//                     onTap: () {
//                       setState(() {
//                         isToggled = !isToggled;
//                       });
//                     },
//                     child: isToggled
//                         ? Icon(Icons.visibility_off_sharp)
//                         : Icon(Icons.visibility),
//                   ),
//                   controller: passwordController,
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'field required';
//                     } else if (value.length < 5) {
//                       return 'password too weak';
//                     }
//                     return null;
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                         onPressed: () {}, child: Text('Forget your password')),
//                     Icon(Icons.arrow_forward, color: Colors.green),
//                   ],
//                 ),
//                 MaterialButton(
//                   height: 45,
//                   minWidth: double.infinity,
//                   shape: ContinuousRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   color: isLoading ? Colors.green : Colors.red,
//                   child: isLoading && circularProgressIndicator
//                       ? CircularProgressIndicator(color: Colors.blue)
//                       : Text('Login'),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate() && isLoading) {
//                       setState(() {
//                         circularProgressIndicator = true;
//                       });
//
//                       try {
//                         final result = await userController.login(
//                           email: emailController.text,
//                           password: passwordController.text,
//                         );
//
//                         if (result.first == true) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Login successful')),
//                           );
//
//                           await userController
//                               .getUser(uid: userController.user!.uid)
//                               .then(
//                             (myUser) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       InterFace(users: myUser),
//                                 ),
//                               );
//                             },
//                           );
//
//                           if (userController.user == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('User not found')),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(result[1])),
//                           );
//                         }
//                       } catch (error) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('An error occurred: $error')),
//                         );
//                       } finally {
//                         setState(() {
//                           circularProgressIndicator = false;
//                         });
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(height: 3, width: 160, color: Colors.green),
//                     Text('or'),
//                     Container(height: 3, width: 160, color: Colors.green),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/apple.png'),
//                     ),
//                     SizedBox(width: 20),
//                     InkWell(onTap: (){
//
//
//                     }, child: Text('continue with Apple')),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/google.png'),
//                     ),
//                     SizedBox(width: 20),
//                     InkWell(
//                       onTap: () async {
//                         User? user = await signInWithGoogle();
//                         if (user != null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Login successful')),
//                           );
//
//                           await userController.getUser(uid: user.uid).then(
//                             (myUser) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       InterFace(users: myUser),
//                                 ),
//                               );
//                             },
//                           );
//
//                           if (userController.user == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('User not found')),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Google sign-in failed')),
//                           );
//                         }
//                       },
//                       child: Text('continue with Google'),
//                     ),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SignUp()));
//                   },
//                   child: Text('create a LionTrade Account'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/CustomText.dart';
import 'package:cryptomania/Guest_page.dart';
import 'package:cryptomania/InterFace.dart';
import 'package:cryptomania/SignUp.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'ResetPassword.dart';

class Login extends StatefulWidget {
  final Users? users;
  const Login({
    super.key,
    this.users,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SignUp signUp = SignUp();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final userController = UserController();
  bool isLoading = true;
  bool isToggled = true;
  bool circularProgressIndicator = false;

  final _formKey = GlobalKey<FormState>();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    return user;
  }

  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final user = userCredential.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );

        await userController.getUser(uid: user.uid).then(
          (myUser) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InterFace(users: myUser),
              ),
            );
          },
        );

        if (userController.user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not found')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple sign-in failed')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Login',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomText(
                  labelText: 'email',
                  controller: emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field required';
                    } else if (value.length < 5) {
                      return 'email combination wrong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomText(
                  obscureText: isToggled,
                  labelText: 'password',
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isToggled = !isToggled;
                      });
                    },
                    child: isToggled
                        ? Icon(Icons.visibility_off_sharp)
                        : Icon(Icons.visibility),
                  ),
                  controller: passwordController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field required';
                    } else if (value.length < 5) {
                      return 'password too weak';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => ForgotPasswordDialog());
                        },
                        child: Text('Forget your password')),
                    Icon(Icons.arrow_forward, color: Colors.green),
                  ],
                ),
                MaterialButton(
                  height: 45,
                  minWidth: double.infinity,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: isLoading ? Colors.green : Colors.red,
                  child: isLoading && circularProgressIndicator
                      ? CircularProgressIndicator(color: Colors.blue)
                      : Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && isLoading) {
                      setState(() {
                        circularProgressIndicator = true;
                      });

                      try {
                        final result = await userController.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (result.first == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login successful')),
                          );

                          await userController
                              .getUser(uid: userController.user!.uid)
                              .then(
                            (myUser) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InterFace(users: myUser),
                                ),
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result[1])),
                          );
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $error')),
                        );
                      } finally {
                        setState(() {
                          circularProgressIndicator = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 3, width: 160, color: Colors.green),
                    Text('or'),
                    Container(height: 3, width: 160, color: Colors.green),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/apple.png'),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        await signInWithApple();
                      },
                      child: Text('continue with Apple'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/google.png'),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login successful')),
                          );

                          await userController.getUser(uid: user.uid).then(
                            (myUser) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InterFace(users: myUser),
                                ),
                              );
                            },
                          );

                          if (userController.user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User not found')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Google sign-in failed')),
                          );
                        }
                      },
                      child: Text('continue with Google'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text('create a Bee CoinCap Account'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GuestPage()));
                  },
                  child: Text('continue as a guest'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
