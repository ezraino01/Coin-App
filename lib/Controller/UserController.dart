

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptomania/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserController {
  final auth = FirebaseAuth.instance;
  late UserCredential? userCredential;
  final accountCollection = FirebaseFirestore.instance.collection("users");
  late User? user; // Initialize it with null

  Future<List> signUp({required String email, required String password}) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = cred.user;
       user?.sendEmailVerification();
      return [true, 'Verification email sent'];
    } on FirebaseException catch (e) {
      print('..................$e');
      if (e.code == 'weak password') {
        return [false, 'the password you provided is weak'];
      } else if (e.code == 'email already in use') {
        print('...........................$e');
        return [false, 'an account with same email already exist'];
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

  Future<bool>isEmailVerified()async{
    await user!.reload();
    user=auth.currentUser;
    return user!.emailVerified;
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

      if(userCredential.user!.emailVerified==true){
       // userCredential.user!.sendEmailVerification();
        return[false, 'email not verified'];
      }
      return [true, 'Login successful'];

    } on FirebaseAuthException catch (e) {
      print(e.code);
      return [false, 'Wrong email and password combination'];
    } catch (e) {
      print(e.toString());
      return [false, 'An unexpected error occurred'];
    }
  }

  Future <List<Users>>getAllUsers() async {
    List<Users> userList = [];
    try {
      final data = await accountCollection.get();
      for(QueryDocumentSnapshot<Map<String, dynamic>> document in data.docs){
        Users user = Users.fromMap(document.data());
        userList.add(user);
        print('All users: ${userList.first.amount}');
      }
      // Do something with the userList

    } catch (e) {
      print('Error getting users: $e');
    }
    return userList;
  }

  Future<void>logOut()async{
    try{
      await FirebaseAuth.instance.signOut();

    }catch(error){
      print('error logging out: $error');
    }
  }

  // Future<List> BuyCrypto(
  //     {required String currentPrice, required String selectedCoin, required double amount, required String userDocId}) async {
  //   final firestore = FirebaseFirestore.instance;
  //   try {
  //     // Get user references based on email
  //     final senderQuery =
  //     await accountCollection.where('email', isEqualTo: senderEmail).get();
  //     final receiverQuery = await accountCollection
  //         .where('email', isEqualTo: receiverEmail)
  //         .get();
  //
  //     if (senderQuery.docs.isNotEmpty && receiverQuery.docs.isNotEmpty) {
  //       final senderDoc = accountCollection.doc(senderQuery.docs.first.id);
  //       final receiverDoc = accountCollection.doc(receiverQuery.docs.first.id);
  //       print('...............Sender............$senderDoc');
  //       print('..................Receiver.........$receiverDoc');
  //       // Start a Firestore transaction
  //       await firestore.runTransaction((transaction) async {
  //         // Get the latest balances
  //         final senderData = await transaction.get(senderDoc);
  //         final receiverData = await transaction.get(receiverDoc);
  //         double convertSenderBalance = double.parse(senderData['accBalance']);
  //         double convertReceiverBalance = double.parse(receiverData['accBalance']);
  //         // Check if the sender has enough balance
  //         print('...............convertSender............$convertSenderBalance');
  //         print('..................convertReceiver.........$convertReceiverBalance');
  //         if (convertSenderBalance >= amount) {
  //           // Update balances
  //           print('...............convertSenderBalance............$convertSenderBalance');
  //           print('..................convertReceiverBalance.........$convertReceiverBalance');
  //           transaction
  //               .update(senderDoc, {'accBalance':( convertSenderBalance - amount).toString()});
  //           transaction.update(
  //               receiverDoc, {'accBalance': (convertReceiverBalance + amount).toString()});
  //         } else {
  //           return [false,'Insufficient balancemmmmmmm'];
  //           //return [false,'Insufficient balance'];
  //           // Handle insufficient balance
  //
  //         }
  //         //return [true,'Transaction successfully'];
  //       });
  //     } else {
  //       // return [false,'User not found'];
  //       //throw Exception('User not found');
  //       return [false,'User not found based on email'];
  //       // Handle user not found based on email
  //
  //     }
  //     return [true,'Transaction successfully'];
  //   } catch (e) {
  //     print('Transaction failed: $e');
  //     return [false,'User not found'];
  //     //throw Exception();
  //     return [false,'Transaction failure or user not found'];
  //     // Handle transaction failure or user not found
  //
  //   }
  //
  // }
  //
  Future<List> buyCrypto({
  required String currentPrice,
  required String selectedCoin,
  required double amount,
  required String userDocId,
  }) async {
  final firestore = FirebaseFirestore.instance;
  final accountCollection = firestore.collection('users');

  try {
  final userDoc = accountCollection.doc(userDocId);
  print('User Document: $userDoc');

  // Check if the document exists
  final docSnapshot = await userDoc.get();
  if (!docSnapshot.exists) {
  await userDoc.set({
  'balance': '1000.0', // You can set an initial balance here
  'holdings': {}
  });
  print('Created a new user document with initial balance');
  }

  return await firestore.runTransaction((transaction) async {
  final userData = await transaction.get(userDoc);

  double userBalance = double.parse(userData['balance'].toString());
  Map<String, dynamic> userHoldings = Map<String, dynamic>.from(userData['holdings'] ?? {});

  print('User Balance: $userBalance');
  if (userBalance >= amount) {
  double cryptoAmount = amount / double.parse(currentPrice);
  print('Crypto Amount: $cryptoAmount');

  double newBalance = userBalance - amount;
  transaction.update(userDoc, {'balance': newBalance.toString()});

  if (userHoldings.containsKey(selectedCoin)) {
  userHoldings[selectedCoin] += cryptoAmount;
  } else {
  userHoldings[selectedCoin] = cryptoAmount;
  }
  transaction.update(userDoc, {'holdings': userHoldings});

  print('Transaction completed successfully');
  return [true, 'Transaction successful'];
  } else {
  print('Insufficient balance');
  return [false, 'Insufficient balance'];
  }
  }).catchError((e) {
  print('Transaction failed inside transaction: $e');
  return [false, 'Transaction failure or user not found'];
  });
  } catch (e) {
  print('Transaction failed: $e');
  return [false, 'Transaction failure or user not found'];
  }
  }

}

