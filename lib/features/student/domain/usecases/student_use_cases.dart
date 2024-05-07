import '../../../data/data_source/remote/firebase_remote_datasource.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class StudentUseCases {
  final StudentRepository studentRepository;
  final FirebaseRemoteDataSource remoteDataSource;

  StudentUseCases(this.studentRepository, this.remoteDataSource);

  // Updated to include username in the registration process
  Future<Student?> registerWithEmailPassword(String username, String email, String password) async {
    return studentRepository.registerWithEmailPassword(username, email, password);
  }
  Future<Student?> loginWithEmailPassword(String email, String password) async {
    return studentRepository.loginWithEmailPassword(email, password);
  }

 

  Future<void> logout() async {
    return studentRepository.logout();
  }

  Future<List<Student>> getAllStudents() {
    return remoteDataSource.fetchAllStudents();
  }
}
