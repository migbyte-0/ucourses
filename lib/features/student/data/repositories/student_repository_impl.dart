import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ucourses/features/student/data/models/student_model.dart';

import '../../../data/data_source/remote/firebase_remote_datasource.dart';
import '../../domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final FirebaseRemoteDataSource remoteDataSource;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StudentRepositoryImpl(this.remoteDataSource);

  @override
  Future<StudentModel> registerWithEmailPassword(String username, String email, String password) async {
    try {
      return await remoteDataSource.registerWithEmailPassword(username, email, password);
    } catch (e) {
      print("Repository Registration Error: $e");
      rethrow;
    }
  }

  @override
  Future<StudentModel> loginWithEmailPassword(String email, String password) {
    return remoteDataSource.loginWithEmailPassword(email, password);
  }

 

  @override
  Future<List<StudentModel>> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs
          .map((doc) => StudentModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error fetching student data: $e');
      throw Exception('Failed to fetch students');
    }
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}
