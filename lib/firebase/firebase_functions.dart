import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Magmo3aModel.dart';
import '../models/StudentModel.dart';
import '../models/usermodel.dart';

class FirebaseFunctions {
  static CollectionReference<Magmo3amodel> getMagmo3asCollection() {
    return FirebaseFirestore.instance
        .collection("magmo3as")
        .withConverter<Magmo3amodel>(
      fromFirestore: (snapshot, _) {
        return Magmo3amodel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addMagmo3a(Magmo3amodel Magmo3aModel) {
    var collection = getMagmo3asCollection();
    var docRef = collection.doc();
    Magmo3aModel.id = docRef.id;
    return docRef.set(Magmo3aModel);
  }

  static Stream<QuerySnapshot<Magmo3amodel>> getMagmo3as(String grade) {
    var collection = getMagmo3asCollection();
    return collection.where("userid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("grade", isEqualTo: grade).snapshots();
  }

  static Stream<QuerySnapshot<Magmo3amodel>> getMagmo3asWithId(String? id) {
    var collection = getMagmo3asCollection();
    return collection.where("id", isEqualTo: id).snapshots();
  }


  static Future<void> deleteMagmo3a(String id) {
    return getMagmo3asCollection().doc(id).delete();
  }




  static CollectionReference<Studentmodel> getagmo3aSubcollection(
      String magmo3aId) {
    return getMagmo3asCollection()
        .doc(magmo3aId)
        .collection("studentss")
        .withConverter<Studentmodel>(
      fromFirestore: (snapshot, _) {
        return Studentmodel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addStudent(String magmo3aId, Studentmodel student) async {
    print('Adding student to Firestore...');
    var subcollection = getagmo3aSubcollection(magmo3aId);
    var docRef = subcollection.doc();
    student.id = docRef.id;
    try {
      await docRef.set(student);
      print('Student added to Firestore successfully!');
    } catch (e) {
      print('Error adding student to Firestore: $e');
    }
  }

  static Stream<QuerySnapshot<Studentmodel>> getMagmo3aSubdocuments(
      String magmo3aId,String grade) {
    var subcollection = getagmo3aSubcollection(magmo3aId);
    return subcollection.where("grade",isEqualTo: grade).snapshots();
  }

  static Future<void> deleteStudent(String magmo3aId, String subdocumentId) {
    return getagmo3aSubcollection(magmo3aId).doc(subdocumentId).delete();
  }


  static Future<void> updateStudent(String magmo3aId, String studentId, Studentmodel updatedStudent) async {
    print('Updating student in Firestore...');
    var subcollection = getagmo3aSubcollection(magmo3aId);
    var docRef = subcollection.doc(studentId);
    try {
      await docRef.update(updatedStudent.toJson());
      print('Student updated in Firestore successfully!');
    } catch (e) {
      print('Error updating student in Firestore: $e');
    }
  }
  static login(String emailAddress, String password,
      {required String Username,
        required Function onSucsses,
        required Function onEror}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      credential.user?.emailVerified;
      if (credential.user?.emailVerified == true) {
        onSucsses();
      }
    } on FirebaseAuthException catch (e) {
      onEror(e.message);
    }
  }

  static Future<Usermodel?> ReadUserData() async {
    var collection = getUsersCollection();
    DocumentSnapshot<Usermodel> docUser = await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docUser.data();
  }

  static createAccount(
      String emailAddress,
      String password, {
        required Function onSucsses,
        required Function onEror,
        required String Username,
      }) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      Usermodel user = Usermodel(
          id: credential.user!.uid, name: Username, email: emailAddress);
      addUser(user);
      onSucsses();
    } on FirebaseAuthException catch (e) {
      onEror(e.message);
    } catch (e) {
      onEror(e.toString());
    }
  }

  static CollectionReference<Usermodel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<Usermodel>(
      fromFirestore: (snapshot, _) {
        return Usermodel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
  }

  static addUser(Usermodel user) {
    var colliction = getUsersCollection();
    var docref = colliction.doc(user.id);
    docref.set(user);
  }


}
