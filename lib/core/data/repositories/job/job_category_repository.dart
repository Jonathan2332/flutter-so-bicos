import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';

abstract class JobCategoryRepository {
  Future<Result<List<JobCategory>>> getAllCategories();
}