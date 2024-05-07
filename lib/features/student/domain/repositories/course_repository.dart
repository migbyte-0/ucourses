// lib/domain/repositories/course_repository.dart

import '../entities/course_entity.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course> addCourse(Course course);
  Future<void> editCourse(String courseId, Course course);
  Future<void> deleteCourse(String courseId);
    Future<Course> getCourseById(String courseId);

}
