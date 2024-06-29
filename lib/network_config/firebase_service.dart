import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../data/hive-helper.dart';
import '../main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utilis/app_preferences.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDvucuzUkiSI6_W2uFCUXoYGvwkoYtjK3s",
        appId: "1:268459879851:android:5b3867c3ef984e2bb036ee",
        messagingSenderId: '268459879851',
        projectId: "codecoy-5d6fa",
        storageBucket: 'codecoy-5d6fa.appspot.com',
      ),
    );
  }

  static Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  static Future<User?> registerWithEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required String designation}) async {
    try {
      EasyLoading.show(status: 'Registering...');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      userCredential.user!.sendEmailVerification();
      await user?.updateDisplayName(name);
      await user?.reload();
      user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(email).set({
          'name': name,
          'email': email,
          'uid': user.uid,
          'image_url': 'noimage',
          'designation': designation,
          'registration_date': DateTime.now().toString()
        });
      }
      EasyLoading.showSuccess(
          'Verify your email by clicking link sent at $email');
      return user;
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(e.toString().split(']')[1]);
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential;
    try {
      EasyLoading.show(status: 'Logging in...');
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          EasyLoading.showSuccess('Log-in successful!');
          return userCredential.user;
        } else {
          await userCredential.user!.sendEmailVerification();
          EasyLoading.showSuccess(
              'Verify you email by clicking the link sent at ${userCredential.user!.email}');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return null;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
      EasyLoading.show(status: 'progressing..');
      DocumentSnapshot<Map<String, dynamic>> document =
          await _firestore.collection('users').doc(email).get();
      if (document.exists) {
        await _auth.sendPasswordResetEmail(email: email);
        EasyLoading.showSuccess('Password reset link sent');
        return true;
      } else {
        EasyLoading.showInfo('Email not registered');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return false;
    }
  }

  static Future<bool> uploadPictureBytes(
      Uint8List pictureBytes, mimeType) async {
    try {
      print('Mime type : ${mimeType}');
      EasyLoading.show(status: 'Uploading...');
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profiles/${preferences.getString(AppPrefs.keyEmail)}.png');
      SettableMetadata metadata = SettableMetadata(contentType: mimeType);
      UploadTask uploadTask = storageReference.putData(pictureBytes);
      await uploadTask;
      String downloadUrl = await storageReference.getDownloadURL();
      await _firestore
          .collection('users')
          .doc(preferences.getString(AppPrefs.keyEmail))
          .update({'image_url': downloadUrl});
      EasyLoading.showSuccess('Upload successful!');
      return true;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<bool> signOut() async {
    try {
      EasyLoading.show(status: 'Logging out...');
      await _auth.signOut();
      if (preferences.getBool(AppPrefs.keyRememberMe) == true) {
        preferences.remove(AppPrefs.keyIsLogin);
        preferences.remove(AppPrefs.keyName);
        preferences.remove(AppPrefs.keyId);
        await HiveHelper.deleteDatabase();
      } else {
        preferences.clear();
      }
      EasyLoading.showSuccess('Log-out successful!');
      return true;
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      EasyLoading.show(status: 'deleting...');
      await _auth.currentUser!.delete().then((value) async => {
            await _firestore
                .collection('users')
                .doc(preferences.getString(AppPrefs.keyEmail))
                .delete()
          });
      await _storage
          .ref('profiles/${preferences.getString(AppPrefs.keyEmail)}.png')
          .delete();
      preferences.clear();
      EasyLoading.showSuccess('Deleted');
      //HiveHelper.deleteDatabase();
      return true;
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
