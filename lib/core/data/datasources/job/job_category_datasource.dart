import 'package:result_dart/result_dart.dart';

abstract class JobCategoryDatasource {
  Future<Result<JobCategoryApiModel>> getAll();
}