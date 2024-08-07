// import 'package:cryptomania/Email%20verification%20Page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cryptomania/Controller/UserController.dart';
// import 'package:cryptomania/Login.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'CustomText.dart';
// import 'InterFace.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//   final UserController userController = UserController();
//   bool isToggled = true;
//   bool isToggle = true;
//   bool isSwitch = false;
//   bool circularProgressIndicator = false;
//   bool isLoading = true;
//   final _FormKey = GlobalKey<FormState>();
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
//   Future<void> signInWithApple() async {
//     try {
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         accessToken: appleCredential.authorizationCode,
//       );
//
//       final userCredential =
//           await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//
//       final user = userCredential.user;
//
//       if (user != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login successful')),
//         );
//
//         await userController.getUser(uid: user.uid).then(
//           (myUser) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => InterFace(users: myUser),
//               ),
//             );
//           },
//         );
//
//         if (userController.user == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('User not found')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Apple sign-in failed')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $error')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _FormKey,
//             child: Column(
//               children: [
//                 CustomText(
//                   labelText: 'Name',
//                   controller: nameController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'Field required';
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 // CustomText(
//                 //   labelText: 'Email',
//                 //   controller: emailController,
//                 //   validator: (String? value) {
//                 //     if (value!.isEmpty) {
//                 //       return 'Field required';
//                 //     }
//                 //   },
//                 // ),
//                 CustomText(
//                   labelText: 'Email',
//                   controller: emailController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'Email is required';
//                     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                         .hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 CustomText(
//                   labelText: 'Password',
//                   obscureText: isToggled,
//                   controller: passwordController,
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
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'Field required';
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 CustomText(
//                   labelText: 'Confirm Password',
//                   obscureText: isToggle,
//                   controller: confirmPassController,
//                   suffixIcon: InkWell(
//                     onTap: () {
//                       setState(() {
//                         isToggle = !isToggle;
//                       });
//                     },
//                     child: isToggle
//                         ? Icon(Icons.visibility_off)
//                         : Icon(Icons.visibility),
//                   ),
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'Field required';
//                     }
//                     if (passwordController.text != confirmPassController.text) {
//                       return 'Passwords do not match';
//                     }
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Switch(
//                       value: isSwitch,
//                       onChanged: (value) {
//                         setState(() {
//                           isSwitch = value;
//                         });
//                       },
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('Terms and Conditions'),
//                     ),
//                   ],
//                 ),
//                 MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: isSwitch && circularProgressIndicator
//                       ? CircularProgressIndicator()
//                       : Text(
//                           'Sign up',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                   color: isSwitch ? Colors.green : Colors.grey,
//                   minWidth: double.infinity,
//                   height: 50,
//                   onPressed: () async {
//                     if (_FormKey.currentState!.validate() && isSwitch) {
//                       setState(() {
//                         circularProgressIndicator = true;
//                       });
//
//                       try {
//                         final result = await userController.signUp(
//                           email: emailController.text,
//                           password: passwordController.text,
//                         );
//
//                         if (result[0]) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(result[1])),
//                           );
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       EmailVerificationScreen()));
//
//                           // if (userController.user != null) {
//                           //   await userController.registeration(
//                           //     user: Users(
//                           //       ID: userController.user!.uid,
//                           //       name: nameController.text,
//                           //       email: emailController.text,
//                           //       password: passwordController.text,
//                           //       amount: '2000.0',
//                           //     ),
//                           //   );
//                           //   Navigator.pushReplacement(
//                           //     context,
//                           //     MaterialPageRoute(builder: (context) => Login()),
//                           //   );
//                           // }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(result[1])),
//                           );
//                         }
//                       } catch (error) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("An error occurred: $error")),
//                         );
//                       } finally {
//                         setState(() {
//                           circularProgressIndicator = false;
//                         });
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Login()));
//                       },
//                       child: Text('Already have an account?'),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/apple.png'),
//                     ),
//                     SizedBox(width: 20),
//                     InkWell(
//                       onTap: () async {
//                         await signInWithApple();
//                       },
//                       child: Text('continue with Apple'),
//                     ),
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
//                 // Row(
//                 //   children: [
//                 //     InkWell(
//                 //       onTap: () {},
//                 //       child: CircleAvatar(
//                 //         maxRadius: 30,
//                 //         child: Image.network(
//                 //             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cryptomania/Terms%20and%20Conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/Login.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'CustomText.dart';
import 'Email verification Page.dart';
import 'InterFace.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final UserController userController = UserController();
  bool isToggled = true;
  bool isToggle = true;
  bool isSwitch = false;
  bool circularProgressIndicator = false;
  bool isLoading = true;
  final _FormKey = GlobalKey<FormState>();

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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _FormKey,
            child: Column(
              children: [
                CustomText(
                  labelText: 'Name',
                  controller: nameController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Field required';
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomText(
                  labelText: 'Email',
                  controller: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomText(
                  labelText: 'Password',
                  obscureText: isToggled,
                  controller: passwordController,
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Field required';
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomText(
                  labelText: 'Confirm Password',
                  obscureText: isToggle,
                  controller: confirmPassController,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isToggle = !isToggle;
                      });
                    },
                    child: isToggle
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Field required';
                    }
                    if (passwordController.text != confirmPassController.text) {
                      return 'Passwords do not match';
                    }
                  },
                ),
                Row(
                  children: [
                    Switch(
                      value: isSwitch,
                      onChanged: (value) {
                        setState(() {
                          isSwitch = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      child: Text('Terms and Conditions'),
                    ),
                  ],
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: isSwitch && circularProgressIndicator
                      ? CircularProgressIndicator()
                      : Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                  color: isSwitch ? Colors.green : Colors.grey,
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    if (_FormKey.currentState!.validate() && isSwitch) {
                      setState(() {
                        circularProgressIndicator = true;
                      });

                      try {
                        final result = await userController.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (result[0]) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result[1])),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmailVerificationScreen(),
                            ),
                          );
                          if (userController.user != null) {
                            await userController.registeration(
                              user: Users(
                                ID: userController.user!.uid,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                amount: '2000.0',
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result[1])),
                          );
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("An error occurred: $error")),
                        );
                      } finally {
                        setState(() {
                          circularProgressIndicator = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('Already have an account?'),
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
