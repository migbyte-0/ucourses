import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/usecases/student_use_cases.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  final StudentUseCases studentUseCases;

  StudentListCubit(this.studentUseCases) : super(StudentListInitial());

  void fetchAllStudents() async {
    try {
      emit(StudentListLoading());
      final students = await studentUseCases.getAllStudents();
      if (students.isEmpty) {
        emit(StudentListEmpty());
      } else {
        emit(StudentListLoaded(students));
      }
    } catch (e) {
      emit(StudentListError(e.toString()));
    }
  }
}
