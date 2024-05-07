import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String username;
  final String email;
  final DateTime createdAt;

  Student({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  factory Student.fromFirestore(
      Map<String, dynamic> firestoreData, String documentId) {
    return Student(
      id: documentId,
      username: firestoreData['username'] as String,
      email: firestoreData['email'] as String,
      createdAt: (firestoreData['createdAt'] as Timestamp).toDate(),
     
    );
  }

  factory Student.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Student.fromFirestore(data, doc.id);
  }
}
