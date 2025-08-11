import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';

abstract class JobDataSource {
  Future<Result<List<JobApiModel>>> getAllJobs();
  Future<Result<List<JobApiModel>>> getJobsByAuthor(String author);
  Future<Result<void>> publishJob(JobApiModel job);
  Future<Result<void>> updateJob(JobApiModel job);
  Future<Result<void>> deleteJob(JobApiModel job);
}