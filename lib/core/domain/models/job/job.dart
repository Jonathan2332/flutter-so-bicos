// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:so_bicos/core/domain/models/job/job_category.dart';

class Job {
  String title;
  String description;
  JobCategory category;
  String author;
  DateTime date;
  Job({
    required this.title,
    required this.description,
    required this.category,
    required this.author,
    required this.date,
  });
}
