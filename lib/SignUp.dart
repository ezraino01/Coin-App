import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/Login.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomText.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final UserController userController = UserController();
  bool isToggled = false;
  bool isToggle = false;
  bool toggle = false;
  final _FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
        ],
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
                      return 'field require';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  labelText: 'Email',
                  controller: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'field required';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  labelText: 'username(optional)',
                  validator: (username) {},
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  labelText: 'password',
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          if (isToggled == true) {
                            isToggled = false;
                          } else {
                            isToggled = true;
                          }
                        });
                      },
                      child: isToggled
                          ? Icon(Icons.visibility_off_sharp)
                          : Icon(Icons.visibility)),
                  obscureText: isToggled,
                  controller: passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'field required';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  labelText: 'Confirm Password',
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          if (isToggle == true) {
                            isToggle = false;
                          } else {
                            isToggle = true;
                          }
                        });
                      },
                      child: isToggle
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  obscureText: isToggle,
                  controller: confirmPassController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'field required';
                    }
                  },
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (toggle == true) {
                            toggle = false;
                          } else {
                            toggle = true;
                          }
                        });
                      },
                      child: toggle
                          ? Icon(
                              Icons.toggle_off_outlined,
                              size: 50,
                              color: Colors.green[100],
                            )
                          : Icon(
                              Icons.toggle_on_outlined,
                              size: 50,
                              color: Colors.green[100],
                            ),
                    ),
                  ],
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.green,
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () async {
                      if (_FormKey.currentState!.validate() &&
                          passwordController.text ==
                              confirmPassController.text) {
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
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('wrong passwords combinations')));
                          }
                        }
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text('Already have an account?'))
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        maxRadius: 30,
                        child: Image.network(
                            'https://ssl.gstatic.com/ui/v1/icons/mail/rfr/logo_gmail_lockup_default_2x_r5.png'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
