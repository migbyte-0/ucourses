// lib/domain/entities/course.dart

class Course {
  final String id;
  final String title;
  final String description;
  final String content;
  final String images;
  final double rating;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.images,
    required this.rating,
  });
}
