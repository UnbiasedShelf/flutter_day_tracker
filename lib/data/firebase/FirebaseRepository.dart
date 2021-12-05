import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_day_tracker/data/auth/google.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';

class FirebaseRepository {
  static final FirebaseRepository instance =
      FirebaseRepository._privateConstructor();
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;

  FirebaseRepository._privateConstructor();

  Future<void> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  Future<UserCredential> signIn() {
    return signInWithGoogle();
  }

  Future<void> signOut() {
    return signOutOfGoogle();
  }

  Future<void> addBusiness(Business business) {
    CollectionReference businesses =
        _firestore.collection(_auth.currentUser!.uid);
    return businesses.add(business.toJson());
  }

  Future<void> updateBusiness(String id, Business business) {
    return _firestore.collection(_auth.currentUser!.uid).doc(id).update(business.toJson());
  }
  Future<void> delete(String id) {
    return _firestore.collection(_auth.currentUser!.uid).doc(id).delete();
  }

  Stream<QuerySnapshot<Object?>> getBusinessStream() {
    Query businesses =
        _firestore.collection(_auth.currentUser!.uid).orderBy("start", descending: true);
    return businesses.snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBusinessById(String id) {
    return _firestore.collection(_auth.currentUser!.uid).doc(id).get();
  }
}
