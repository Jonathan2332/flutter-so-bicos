import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';

abstract class JobRepository {
  Future<Result<List<Job>>> getAllJobs();
  Future<Result<List<Job>>> getJobsByAuthor(String author);
  Future<Result<Job>> publishJob(Job job);
  Future<Result<Job>> updateJob(Job job);
  Future<Result<Job>> deleteJob(Job job);
}