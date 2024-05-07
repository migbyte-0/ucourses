import '../../domain/entities/course_entity.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.images,
    required super.rating,
  });

  // Convert a Course object into a CourseModel
  factory CourseModel.fromCourse(Course course) {
    return CourseModel(
      id: course.id,
      title: course.title,
      description: course.description,
      content: course.content,
      images: course.images,
      rating: course.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'images': images,
      'rating': rating,
    };
  } factory CourseModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CourseModel(
      id: documentId,
      title: data['title'] as String,
      description: data['description'] as String,
      content: data['content'] as String,
      images: data['images'] as String,
      rating: (data['rating'] as num).toDouble(),
    );
  }
}
