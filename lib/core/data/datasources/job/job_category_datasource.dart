import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';

abstract class JobCategoryDataSource {
  Future<Result<List<JobCategoryApiModel>>> getAllCategories();
  Future<Result<JobCategoryApiModel>> getCategoryById(String id);
}