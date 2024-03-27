import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';

List<Map<String, dynamic>> initialChoiceList = [
  {"post": "Public Relations Officer", "choice": ""},
  {"post": "Social Director", "choice": ""},
  {
    "post": "Sports Director",
    "choice": "",
  },
  {"post": "Welfare Secretary", "choice": ""},
  {"post": "Financial Secretary", "choice": ""},
  {"post": "General Secretary", "choice": ""},
  {"post": "Vice President Academics", "choice": ""},
  {
    "post": "Vice President Administration",
    "choice": "",
  },
  {"post": "President", "choice": ""}
];

class VotingService with ListenableServiceMixin {
  final ReactiveValue<List<Map<String, dynamic>>> _votersChoice =
      ReactiveValue(initialChoiceList);

  List<Map<String, dynamic>> get votersChoice => _votersChoice.value;

  bool hasEmptyChoice() {
    bool hasEmptyChoice = false;

    for (var voterChoice in _votersChoice.value) {
      if ((voterChoice['choice'] as String).isEmpty) {
        hasEmptyChoice = true;
        break;
      }
    }
    return hasEmptyChoice;
  }

  updateVotersChoice(int index, String choice) {
    log("updating index ($index) in votersChoice");
    (_votersChoice.value)[index]["choice"] = choice;
    notifyListeners();
    log("Voters choice so far --> ${_votersChoice.value}");
  }

  VotingService() {
    listenToReactiveValues([_votersChoice]);
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      log('Failed to sign in with Google: $error');
    }
    return null;
  }

  increaseVote(String post, String name) async {
    // Reference to the document you want to update
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('nominees').doc(post);

    try {
      // Update the field 'numberField' with the new value
      await documentReference.update({
        name: FieldValue.increment(1),
      });
      log('Document updated successfully!');
    } catch (error) {
      log('Error updating document: $error');
    }
  }

  Future<bool> updateVoteStatus(String uid) async {
    // Reference to the document you want to update or create
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('voted').doc('emails');

    try {
      // Set the document with the field {"uid": true}
      await documentReference.set({
        uid: true,
      });

      return true;
    } catch (error) {
      log('Error uploading email: $error');
    }
    return false;
  }

  Future<bool> isUser400(String regNo, String email) async {
    // Reference to the collection where your documents reside
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('voters');

    try {
      // Perform a query to search for the email field
      log("Checking is reg no: $regNo is $email");
      QuerySnapshot querySnapshot =
          await collectionReference.where(regNo, isEqualTo: email).get();

      // Check if any documents were found
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle errors if any
      log('Error checking email existence: $error');
      return false;
    }
  }

  Future<bool> hasUserVoted(String uid) async {
    // Reference to the collection where your documents reside
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('voted');

    try {
      // Perform a query to search for the email field
      log("Checking if email: $uid is true");
      QuerySnapshot querySnapshot =
          await collectionReference.where(uid, isEqualTo: true).get();

      // Check if any documents were found
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle errors if any
      log('Error checking email existence: $error');
      return false;
    }
  }
}
