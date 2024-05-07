
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ucourses/features/student/data/models/student_model.dart';
import '../../../student/data/models/course_model.dart';

class FirebaseRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<StudentModel> registerWithEmailPassword(String username, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      var user = StudentModel(
        id: userCredential.user!.uid,
        username: username,
        email: email,
        createdAt: DateTime.now(),
      );
      await _firestore.collection('users').doc(user.id).set(user.toJson());
      return user;
    } catch (e) {
      print("DataSource Registration Error: $e");
      rethrow;
    }
  }

  Future<StudentModel> loginWithEmailPassword(String email, String password) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    var doc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
    return StudentModel.fromDocumentSnapshot(doc);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<List<CourseModel>> getCourses() async {
    var querySnapshot = await _firestore.collection('courses').get();
    return querySnapshot.docs.map((doc) {
      return CourseModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }). toList();
  }

  Future<CourseModel> addCourse(CourseModel course) async {
    try {
      DocumentReference docRef = await _firestore.collection('courses').add(course.toJson());
      return CourseModel(
        id: docRef.id,
        title: course.title,
        description: course.description,
        content: course.content,
        images: course.images,
        rating: course.rating,
      );
    } catch (e) {
      print('Error adding course to Firestore: $e');
      throw Exception('Failed to add course: $e');
    }
  }

  Future<void> editCourse(String courseId, CourseModel course) async {
    await _firestore.collection('courses').doc(courseId).update(course.toJson());
  }

  Future<void> deleteCourse(String courseId) async {
    print("Attempting to delete course with ID: $courseId");
    if (courseId.isEmpty) {
      throw ArgumentError("Course ID cannot be empty for deletion.");
    }
    await _firestore.collection('courses').doc(courseId).delete();
  }

  Future<List<StudentModel>> fetchAllStudents() async {
    try {
      var querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs.map((doc) => StudentModel.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Failed to fetch users');
    }
  }  Future<CourseModel> getCourseById(String courseId) async {
    final docSnapshot = await _firestore.collection('courses').doc(courseId).get();
    return CourseModel.fromFirestore(docSnapshot.data() as Map<String, dynamic>, courseId);
  }
}
