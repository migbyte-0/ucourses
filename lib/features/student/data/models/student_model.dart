
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ucourses/features/student/domain/entities/student_entity.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    required super.username,
    required super.email,
    required super.createdAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
   
    );
  }

  factory StudentModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudentModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
