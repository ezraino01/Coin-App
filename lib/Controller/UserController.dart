import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



class UserController {
  final auth = FirebaseAuth.instance;
  late UserCredential? userCredential;
  final accountCollection = FirebaseFirestore.instance.collection("user");
  late User? user; // Initialize it with null
  //
  // Future<void> initializeUser() async {
  //   user = auth.currentUser; // Initialize user asynchronously
  // }

  Future<List> signUp({required String email, required String password}) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = cred.user;
      // user?.sendEmailVerification();
    } on FirebaseException catch (e) {
      print('..................$e');
      if (e.code == 'weak password') {
        return [false, 'the password you provided is weak'];
      } else if (e.code == 'email already in use') {
        print('...........................$e');
        return [false, 'an account with same email alrready exist'];
      }
    } catch (e) {
      return [false, e.toString()];
    }
    return [true, 'signUp successful, verify your email'];
  }

  Future<void> registeration({required Users user}) async {
    try {
      await accountCollection
          .doc(user.ID)
          .set(user.toMap(), SetOptions(merge: false));
    } catch (e) {
      print('not working........................');
      // Handle any potential exceptions here
    }
  }

  Future<Users> getUser({required String uid})async{
    try{
      final myUser= await accountCollection.doc(uid).get();
      return Users.fromMap(myUser.data()!);
    }catch(e){
      rethrow;
    }
  }
  Future<List> login({required String email, required String password}) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      return [true, 'Login successful'];
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return [false, 'Wrong email and password combination'];
    } catch (e) {
      print(e.toString());
      return [false, 'An unexpected error occurred'];
    }
  }



}

