import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

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

  // We can save DocumentReference field if we don't use `withConverter`
  final docRef = firestore.collection('someCollection').doc();
  final data = SomeDocument(docRef: docRef);
  await docRef.set(
    SomeDocument.toJson(data, null),
  );
}
