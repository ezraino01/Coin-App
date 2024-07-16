// import 'package:cryptomania/Controller/UserController.dart';
// import 'package:cryptomania/Login.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'CustomText.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({
//     super.key,
//   });
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
//   bool isToggled = false;
//   bool isToggle = false;
//   bool toggle = false;
//   bool onChanged = false;
//   bool isSwitch = false;
//   bool circularProgressIndicator = false;
//   final _FormKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         actions: [],
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
//                       return 'field require';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomText(
//                   labelText: 'Email',
//                   controller: emailController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'field required';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomText(
//                   labelText: 'username(optional)',
//                   validator: (username) {},
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomText(
//                   labelText: 'password',
//                   suffixIcon: InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (isToggled == true) {
//                             isToggled = false;
//                           } else {
//                             isToggled = true;
//                           }
//                         });
//                       },
//                       child: isToggled
//                           ? Icon(Icons.visibility_off_sharp)
//                           : Icon(Icons.visibility)),
//                   obscureText: isToggled,
//                   controller: passwordController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'field required';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomText(
//                   labelText: 'Confirm Password',
//                   suffixIcon: InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (isToggle == true) {
//                             isToggle = false;
//                           } else {
//                             isToggle = true;
//                           }
//                         });
//                       },
//                       child: isToggle
//                           ? Icon(Icons.visibility_off)
//                           : Icon(Icons.visibility)),
//                   obscureText: isToggle,
//                   controller: confirmPassController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'field required';
//                     }
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Switch(
//                         value: (isSwitch),
//                         onChanged: (value) {
//                           setState(() {
//                             isSwitch = value;
//                           });
//                         }),
//                     TextButton(
//                         onPressed: () {}, child: Text('Terms and Conditions'))
//                   ],
//                 ),
//                 MaterialButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: isSwitch && circularProgressIndicator
//                         ? CircularProgressIndicator()
//                         : Text(
//                             'Sign up',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                     color: isSwitch ? Colors.green : Colors.grey,
//                     minWidth: double.infinity,
//                     height: 50,
//                     onPressed: () async {
//                       if (_FormKey.currentState!.validate() &&
//                           passwordController.text ==
//                               confirmPassController.text &&
//                           isSwitch == true) {
//                         setState(() {
//                           circularProgressIndicator = true;
//                         });
//
//                         try {
//                           final result = await userController.signUp(
//                             email: emailController.text,
//                             password: passwordController.text,
//                           );
//                           if (result[0]) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(result[1])),
//                             );
//                             if (userController.user != null) {
//                               await userController.registeration(
//                                 user: Users(
//                                   ID: userController.user!.uid,
//                                   name: nameController.text,
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   amount: '2000.0',
//                                 ),
//                               );
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Login()));
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           'wrong passwords combinations')));
//                             }
//                           }
//                         } catch (error) {
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text("an error occured: $error")));
//                         }
//                       }
//                     }),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => Login()));
//                         },
//                         child: Text('Already have an account?'))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: CircleAvatar(
//                         maxRadius: 30,
//                         child: Image.network(
//                             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/Login.dart';
import 'package:cryptomania/UserModel.dart';
import 'CustomText.dart';

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
  final _FormKey = GlobalKey<FormState>();

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
                      return 'Field required';
                    }
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
                      onPressed: () {},
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
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/apple.png'),
                        //  child:  Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('continue with Apple'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/google.png'),
                        //  child:  Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('continue with Google'),
                  ],
                ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {},
                //       child: CircleAvatar(
                //         maxRadius: 30,
                //         child: Image.network(
                //             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
