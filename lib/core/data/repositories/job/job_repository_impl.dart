// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';

extension EntityParse on List<JobApiModel> {
  Future<Result<List<Job>>> mapToEntity() =>
      mapFold(_toEntity, (error) => error);
}

extension ModelParse on Job {
  JobApiModel _toModel() {
    return JobApiModel(
      id: id,
      title: title,
      description: description,
      category: category.id,
      author: author,
      date: date.millisecondsSinceEpoch,
    );
  }
}

Job _toEntity(JobApiModel model, JobCategory? category) {
  final date = model.date;
  if(date != null) {
    DateTime.fromMillisecondsSinceEpoch(date);
  }
  else {
    DateTime.now().millisecondsSinceEpoch;
  }
  return Job(
    id: model.id,
    title: model.title ?? "Unknown",
    description: model.description ?? "Unknown",
    category: category ?? JobCategory(id: "unkonwon", name: "Unkonwn"),
    author: model.author ?? "Unknown",
    date: dateTime
  );
}



class JobRepositoryImpl extends JobRepository {
  final JobCategoryDataSource categoryDataSource;
  final JobDataSource dataSource;

  JobRepositoryImpl({
    required this.dataSource,
    required this.categoryDataSource,
  });

  @override
  Future<Result<List<Job>>> getAllJobs() async {
    final categoriesResult = await categoryDataSource.getAllCategories();
    if (categoriesResult.isError()) {
      return Failure(JobFetchAllException(message: "error on fetch all categories"));
    }

    final categories = categoriesResult.getOrNull();
    if (categories == null) {
      return Failure(JobFetchAllException(message: "error on get categories"));
    }

    final jobs = dataSource.getAllJobs().mapFold((jobs) {
      return jobs
          .map(
            (job) => _toEntity(
              job,
              categories.firstOrNull((cat) => cat.id == job.category),
            ),
          )
          .toList();
    }, (e) => e);
    return jobs;
  }

  @override
  Future<Result<List<Job>>> getJobsByAuthor(String author) async {

    final categoriesResult = await categoryDataSource.getAllCategories();
    if (categoriesResult.isError()) {
      return Failure(JobFetchAllException(message: "error on fetch all categories"));
    }

    final categories = categoriesResult.getOrNull();
    if (categories == null) {
      return Failure(JobFetchAllException(message: "error on get categories"));
    }
  }

  @override
  Future<Result<void>> publishJob(Job job) =>
      dataSource.publishJob(job._toModel());

  @override
  Future<Result<void>> updateJob(Job job) =>
      dataSource.updateJob(job._toModel());

  @override
  Future<Result<void>> deleteJob(Job job) =>
      dataSource.deleteJob(job._toModel());
}
