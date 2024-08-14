//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cryptomania/Terms%20and%20Conditions.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cryptomania/UserModel.dart';
// import 'package:cryptomania/Login.dart';
//
// class Profile extends StatefulWidget {
//   final Users users;
//   const Profile({Key? key, required this.users}) : super(key: key);
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   XFile? fileImage;
//   String? _imagePath;
//   @override
//   void initState() {
//     super.initState();
//     _loadImagePath();
//   }
//
//   Future<void> _loadImagePath() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.users.ID)
//           .get();
//       if (userDoc.exists) {
//         setState(() {
//           _imagePath = userDoc['profile_images'];
//         });
//       }
//     } catch (e) {
//       print('Error loading image path: $e');
//     }
//   }
//
//   Future<void> _saveImagePath(String path) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.users.ID)
//           .update({'profile_images': path});
//       print('Image path saved successfully.');
//     } catch (e) {
//       print('Error saving image path: $e');
//     }
//   }
//
//   Future<void> selectImage() async {
//     fileImage = await imagePicker();
//     if (fileImage != null) {
//       String downloadURL = await _uploadImage(fileImage!);
//       setState(() {
//         _imagePath = downloadURL;
//       });
//       await _saveImagePath(downloadURL);
//     }
//   }
//
//   Future<String> _uploadImage(XFile image) async {
//     try {
//       Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('profile_images/${widget.users.ID}');
//       UploadTask uploadTask = storageReference.putFile(File(image.path));
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();
//       print('Image uploaded successfully: $downloadURL');
//       return downloadURL;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return '';
//     }
//   }
//
//   Future<XFile?> imagePicker() async {
//     try {
//       XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (file != null) {
//         return file;
//       } else {
//         print('No image selected');
//         return null;
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           physics: const ScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: height * 0.23,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       selectImage();
//                     },
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ClipOval(
//                           child: CircleAvatar(
//                             radius: 50,
//                             backgroundColor: Colors.white,
//                             child: fileImage != null
//                                 ? Image.file(
//                                     File(fileImage!.path),
//                                     fit: BoxFit.cover,
//                                     height: 100,
//                                     width: 100,
//                                   )
//                                 : (_imagePath != null && _imagePath!.isNotEmpty)
//                                     ? Image.network(
//                                         _imagePath!,
//                                         fit: BoxFit.cover,
//                                         height: 100,
//                                         width: 100,
//                                       )
//                                     : const Icon(
//                                         Icons.photo_size_select_actual_sharp),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 20,
//                     left: 20,
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.users.name,
//                           style: const TextStyle(
//                               fontSize: 20,
//                               fontStyle: FontStyle.italic,
//                               color: Colors.white),
//                         ),
//                         Text(
//                           widget.users.email,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const Login()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey[100],
//                   ),
//                   height: 50,
//                   width: double.infinity,
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.logout,
//                         color: Colors.black45,
//                         size: 30,
//                       ),
//                       Text(
//                         'LogOut',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.black45,
//                         size: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Terms()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   height: 50,
//                   width: double.infinity,
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.branding_watermark_sharp,
//                         color: Colors.black45,
//                         size: 30,
//                       ),
//                       Text(
//                         'Terms and Condition',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.black45,
//                         size: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptomania/Controller/UserController.dart';
import 'package:cryptomania/Terms%20and%20Conditions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:cryptomania/Login.dart';

class Profile extends StatefulWidget {
  final Users users;
  const Profile({Key? key, required this.users}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController userController = UserController();
  XFile? fileImage;
  String? _imagePath;
  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _logOut() async {
    try {
      await userController.logOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    } catch (e) {}
  }

  Future<void> _loadImagePath() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.users.ID)
          .get();
      if (userDoc.exists) {
        setState(() {
          _imagePath = userDoc['profile_images'];
        });
      }
    } catch (e) {
      print('Error loading image path: $e');
    }
  }

  Future<void> _saveImagePath(String path) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.users.ID)
          .update({'profile_images': path});
      print('Image path saved successfully.');
    } catch (e) {
      print('Error saving image path: $e');
    }
  }

  Future<void> selectImage() async {
    fileImage = await imagePicker();
    if (fileImage != null) {
      String downloadURL = await _uploadImage(fileImage!);
      setState(() {
        _imagePath = downloadURL;
      });
      await _saveImagePath(downloadURL);
    }
  }

  Future<String> _uploadImage(XFile image) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${widget.users.ID}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('Image uploaded successfully: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<XFile?> imagePicker() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        return file;
      } else {
        print('No image selected');
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  void _showProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: _imagePath != null
              ? Image.network(_imagePath!)
              : fileImage != null
                  ? Image.file(File(fileImage!.path))
                  : Icon(Icons.photo_size_select_actual_sharp, size: 100),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.23,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showProfilePicture();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: fileImage != null
                                ? Image.file(
                                    File(fileImage!.path),
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  )
                                : (_imagePath != null && _imagePath!.isNotEmpty)
                                    ? Image.network(
                                        _imagePath!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const Icon(
                                        Icons.photo_size_select_actual_sharp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      children: [
                        Text(
                          widget.users.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        Text(
                          widget.users.email,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 220,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              selectImage();
                            },
                            child: Icon(Icons.add_a_photo)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _logOut();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black45,
                        size: 30,
                      ),
                      Text(
                        'LogOut',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black45,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Terms()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.branding_watermark_sharp,
                        color: Colors.black45,
                        size: 30,
                      ),
                      Text(
                        'Terms and Condition',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black45,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
