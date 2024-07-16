// import 'package:cryptomania/Controller/UserController.dart';
// import 'package:cryptomania/CustomText.dart';
// import 'package:cryptomania/InterFace.dart';
// import 'package:cryptomania/SignUp.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:flutter/material.dart';
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
//   bool isToggled = false;
//   bool circularProgressIndicator = false;
//   @override
//   final _FormKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back_ios)),
//         backgroundColor: Colors.grey,
//         title: Text(
//           'Login',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _FormKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomText(
//                   labelText: 'email',
//                   controller: emailController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'field required';
//                     } else {
//                       if (value.length < 5) {
//                         return 'email combination wrong';
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomText(
//                   obscureText: isToggled,
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
//                   controller: passwordController,
//                   validator: (String? value) {
//                     if (value!.isEmpty) {
//                       return 'field required';
//                     } else if (value.length < 5) {
//                       return 'password too weak';
//                     }
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                         onPressed: () {}, child: Text('Forget your password')),
//                     Icon(
//                       Icons.arrow_forward,
//                       color: Colors.green,
//                     )
//                   ],
//                 ),
//                 MaterialButton(
//                   height: 45,
//                   minWidth: double.infinity,
//                   shape: ContinuousRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   color: isLoading ? Colors.green : Colors.red,
//                   child: isLoading && circularProgressIndicator
//                       ? const CircularProgressIndicator(
//                           color: Colors.blue,
//                         )
//                       : Text('Login'),
//                   onPressed: () async {
//                     if (_FormKey.currentState!.validate() &&
//                         isLoading == true) {
//                       setState(() {
//                         circularProgressIndicator = true;
//                       });
//                       final result = await userController
//                           .login(
//                               email: emailController.text,
//                               password: passwordController.text)
//                           .then((list) async {
//                         if (list.first == true) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Login successful')));
//                           // Wait for login to complete before continuing
//                           await userController
//                               .getUser(uid: userController.user!.uid)
//                               .then((myUser) => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           InterFace(users: myUser),
//                                     ),
//                                   ));
//                           // Ensure user is not null before navigating
//                           if (userController.user != null) {
//                             print('user is null......................');
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('User not found')),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(list[1])),
//                           );
//                         }
//                       }).catchError((error) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('An error occurred: $error')),
//                         );
//                       }
//                       );
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 3,
//                       width: 160,
//                       color: Colors.green,
//                     ),
//                     Text('or'),
//                     Container(
//                       height: 3,
//                       width: 160,
//                       color: Colors.green,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: CircleAvatar(
//                         child: Image.network(
//                             'https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png?201609051049'),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text('continue with Apple'),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: CircleAvatar(
//                         child: Image.network(
//                             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB&psig=AOvVaw1JGP2TQhUeaR7xspaA-Xqr&ust=1712417613629000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIiAv-6yq4UDFQAAAAAdAAAAABAE'),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text('continue with Google'),
//                   ],
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => SignUp()));
//                     },
//                     child: Text('create a LionTrade Account'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/CustomText.dart';
import 'package:cryptomania/InterFace.dart';
import 'package:cryptomania/SignUp.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:flutter/material.dart';

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
                    TextButton(onPressed: () {}, child: Text('Forget your password')),
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

                          await userController.getUser(uid: userController.user!.uid).then(
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
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/apple.png'),
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
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('continue with Google'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: const Text('create a LionTrade Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
