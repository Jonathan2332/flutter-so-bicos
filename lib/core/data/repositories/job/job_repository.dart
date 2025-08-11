import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';

abstract class JobRepository {
  Future<Result<List<Job>>> getAllJobs();
  Future<Result<List<Job>>> getJobsByAuthor(String author);
  Future<Result<void>> publishJob(Job job);
  Future<Result<void>> updateJob(Job job);
  Future<Result<void>> deleteJob(Job job);
}