

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../widget/Snackbar.dart';
import '../../styles/colores.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();
User get user=>_firebaseAuth.currentUser!;
  DocumentSnapshot? snapshot;
  Future<bool> Sign_in_with_google(context) async {
    bool result = false;
    try {
       GoogleSignInAccount? googlesignin = await GoogleSignIn().signIn();
       GoogleSignInAuthentication? googleAuth =
          await googlesignin?.authentication;
       AuthCredential  credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
       UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFireStore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL
          });
        }
        result = true;
      }
    } on FirebaseAuthException catch (error) {
      ShowSnackBar(
          context: context, text: error.message, );
      result = false;
    }
    return result;
  }

  Future<void> Sign_in_with_EmailAndPassword(
      {required emailAddress, required password, required context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {

      print(e.code.toString());
      if (e.code == 'user-not-found') {
        ShowSnackBar(
            context: context,
            text: 'No user found for : ${emailAddress} .',
          );
      } else if (e.code == 'wrong-password') {
        ShowSnackBar(
            context: context,
            text: 'Wrong password provided for that user.',
          );

      }

    }
  }



  Future signUpWithEmail(String email, String password, BuildContext context, String name, Future<String> photoURL) async {
    try {


      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;


      try{
        String imageUrl = await photoURL;
        _firebaseFireStore
            .collection('users')
            .doc(user!.uid)
            .set({'username': name, 'uid': user.uid, 'profilePhoto': imageUrl});
      }catch(e){
        print(e.toString());
      }
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print( data['username']);
      await user.updateDisplayName(
          data['username']
      );
      print( data['profilePhoto']);
      await user.updatePhotoURL(data['profilePhoto']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> checkEmail(String email) async {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }

    try {
      List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        return 'Email address is already in use.';
      } else {
        return 'Email address is available.';
      }
    } on FirebaseAuthException catch (e) {
     if(e.message=='The email address is badly formatted.') {
       return 'Please enter a valid email address.';
     } else
    if(e.toString().contains('network error')) {
      return 'There is no internet connection';
    } else {
      return"${e.message}";
    }
    } catch (e) {
    return 'Error: ${e.toString()}';
    }
  }

  Future<bool> isPasswordWeak(String password) async {
    try {
      await FirebaseAuth.instance.checkActionCode(password);
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return true; // password is weak
      }
      return false; // some other error occurred
    } catch (e) {
      return false; // handle the error as needed
    }
  }


}
