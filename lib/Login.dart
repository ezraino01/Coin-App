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
  bool isToggled = false;
  bool circularProgressIndicator = false;
  final _FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.grey,
        title: Text(
          'Login',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              CustomText(
                labelText: 'email',
                controller: emailController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'field required';
                  } else {
                    if (value.length < 5) {
                      return 'email combination wrong';
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                obscureText: isToggled,
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
                controller: passwordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'field required';
                  } else if (value.length < 5) {
                    return 'password too weak';
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {}, child: Text('Forget your password')),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  )
                ],
              ),
              MaterialButton(
                height: 45,
                minWidth: double.infinity,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: isLoading ? Colors.green : Colors.red,
                child: isLoading && circularProgressIndicator
                    ? CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : Text('Login'),
                onPressed: () async {
                  if (_FormKey.currentState!.validate() && isLoading == true) {
                    setState(() {
                      circularProgressIndicator = true;
                    });
                    final result = await userController
                        .login(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((list) async {
                      if (list.first == true) {
                        // Wait for login to complete before continuing
                        await userController
                            .getUser(uid: userController.user!.uid)
                            .then((myUser) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InterFace(users: myUser),
                                  ),
                                ));
                        // Ensure user is not null before navigating
                        if (userController.user != null) {
                          print('user is null......................');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User not found')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(list[1])),
                        );
                      }
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred: $error')),
                      );
                    });
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 3,
                    width: 160,
                    color: Colors.green,
                  ),
                  Text('or'),
                  Container(
                    height: 3,
                    width: 160,
                    color: Colors.green,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
