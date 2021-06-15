import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SomeDocument {
  final DocumentReference docRef;

  SomeDocument({
    required this.docRef,
  });

  static SomeDocument fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return SomeDocument(
      docRef: snapshot.data()!['docRef'] as DocumentReference,
    );
  }

  static Map<String, dynamic> toJson(
    SomeDocument data,
    SetOptions? options,
  ) {
    return {
      'docRef': data.docRef,
    };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp();
  final firestore = FirebaseFirestore.instanceFor(app: app);
  final docRef = firestore
      .collection('someCollection')
      .withConverter<SomeDocument>(
        fromFirestore: SomeDocument.fromJson,
        toFirestore: SomeDocument.toJson,
      )
      .doc();
  await docRef.set(
    SomeDocument(docRef: docRef),
  );
}
