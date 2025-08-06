import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';

abstract class JobDataSource {
  Future<Result<List<JobApiModel>>> getAllJobs();
  Future<Result<List<JobApiModel>>> getJobsByAuthor(String author);
  Future<Result<JobApiModel>> publishJob(JobApiModel job);
  Future<Result<JobApiModel>> updateJob(JobApiModel job);
  Future<Result<JobApiModel>> deleteJob(JobApiModel job);
}