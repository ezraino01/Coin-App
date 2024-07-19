
import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/CustomText.dart';
import 'package:cryptomania/InterFace.dart';
import 'package:cryptomania/SignUp.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
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
                        onPressed: () {}, child: Text('Forget your password')),
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

                          if (userController.user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User not found')),
                            );
                          }
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
                      onTap: () => _launchUrl('https://www.apple.com/'),
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
                      onTap: () => _launchUrl('https://www.google.com/'),
                      child: Text('continue with Google'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text('create a LionTrade Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:cryptomania/Controller/UserController.dart';
// import 'package:cryptomania/CustomText.dart';
// import 'package:cryptomania/InterFace.dart';
// import 'package:cryptomania/SignUp.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
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
//
//   Future<void> _launchUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
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
//                                 (myUser) {
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
//                     InkWell(
//                       onTap: () => _launchUrl('https://www.apple.com/'),
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
//                       onTap: () => _launchUrl('https://www.google.com/'),
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
