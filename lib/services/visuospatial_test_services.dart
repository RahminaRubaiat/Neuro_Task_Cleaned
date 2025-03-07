import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:neuro_task_android/pages/homepage.dart';
import 'package:neuro_task_android/pages/splash_screen.dart';

class VisuospatialTestServices{
  String doc = '';
  Future<void> visuospatialTestDataToFirebase(Map<int,Map<String,dynamic>> gameInformation) async{
    gameInformation.forEach((key, value) {
      DateTime now = DateTime.now();
      String paddedKey = key.toString().padLeft(2, '0');
      doc = '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second} - $paddedKey';
      FirebaseFirestore.instance.collection('Visuospatial Test - 1008 - $patientemail').doc('$doc - $patientId').set(value);
    });
  }

  Future<void> visuospatialTestScreenshotToFirebaseStorage(Uint8List imageBytes) async{
    var firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref('Images');
    var imageName = 'Visuospatial Test - 1008 - $patientemail - ${DateTime.now().microsecondsSinceEpoch}.png';
    await firebaseStorageRef.child(imageName).putData(imageBytes);
    var downloadURL = await firebaseStorageRef.child(imageName).getDownloadURL();
    FirebaseFirestore.instance.collection('Visuospatial Test - 1007 - $patientemail - Image').doc('$doc - $patientId').set({
      'Screenshot Url' : downloadURL,
    });
    debugPrint('Image uploaded to Firebase Storage: $downloadURL');
  }
}