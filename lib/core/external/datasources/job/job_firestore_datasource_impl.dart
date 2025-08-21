import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';

class JobFirestoreDataSourceImpl extends JobDataSource {
  final FirebaseFirestore db;
  final jobsPath = "jobs";

  JobFirestoreDataSourceImpl({required this.db});

  @override
  Future<Result<List<JobApiModel>>> getAllJobs() async {
    final ref = db
        .collection(jobsPath)
        .withConverter(
          fromFirestore: JobApiModel.fromFirestore,
          toFirestore: (job, options) => job.toFirestore(),
        );

    final snapshot = await ref.get();
    if (snapshot.size > 0) {
      return Success(snapshot.docs.map((e) => e.data()).toList());
    } else {
      return Failure(
        JobFetchAllException(message: "Error on get all jobs, size is empty"),
      );
    }
  }

  @override
  Future<Result<List<JobApiModel>>> getJobsByAuthor(String author) async {
    final ref = db
        .collection(jobsPath)
        .where("author", isEqualTo: author)
        .withConverter(
          fromFirestore: JobApiModel.fromFirestore,
          toFirestore: (job, options) => job.toFirestore(),
        );
    final snapshot = await ref.get();

    if (snapshot.size > 0) {
      return Success(snapshot.docs.map((e) => e.data()).toList());
    } else {
      return Failure(
        JobFetchByAuthorException(
          message: "Error on fetch job by author, size is empty",
        ),
      );
    }
  }

  @override
  Future<Result<List<JobApiModel>>> getJobsByCategoryId(String categoryId) async {
    final ref = db
        .collection(jobsPath)
        .where("category", isEqualTo: categoryId)
        .withConverter(
          fromFirestore: JobApiModel.fromFirestore,
          toFirestore: (job, options) => job.toFirestore(),
        );
    final snapshot = await ref.get();

    if (snapshot.size > 0) {
      return Success(snapshot.docs.map((e) => e.data()).toList());
    } else {
      return Failure(
        JobFetchByCategoryException(
          message: "Error on fetch job by category, size is empty",
        ),
      );
    }
  }

  @override
  Future<Result<void>> publishJob(JobApiModel job) async {
    final jobId = job.id;
    if (jobId != null) {
      final ref = db
          .collection(jobsPath)
          .withConverter(
            fromFirestore: JobApiModel.fromFirestore,
            toFirestore: (job, options) => job.toFirestore(),
          );

      await ref.add(job);
      return Success(Unit);
    } else {
      return Failure(
        JobCreateException(message: "error on create job: jobId is null"),
      );
    }
  }

  @override
  Future<Result<void>> updateJob(JobApiModel job) async {
    final jobId = job.id;
    if (jobId != null) {
      final ref = db
          .collection(jobsPath)
          .doc(jobId.toString())
          .withConverter(
            fromFirestore: JobApiModel.fromFirestore,
            toFirestore: (job, options) => job.toFirestore(),
          );

      await ref.set(job);
      return Success(Unit);
    } else {
      return Failure(
        JobUpdateException(message: "error on update job: jobId is null"),
      );
    }
  }

  @override
  Future<Result<void>> deleteJob(JobApiModel job) async {
    final jobId = job.id;
    if (jobId != null) {
      final ref = db.collection(jobsPath).doc(jobId.toString());
      await ref.delete();
      return Success(Unit);
    } else {
      return Failure(
        JobDeleteException(message: "error on delete job: jobId is null"),
      );
    }
  }
}
