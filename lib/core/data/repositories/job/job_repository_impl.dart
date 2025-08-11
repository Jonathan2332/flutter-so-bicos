// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';

extension MapEntityParse on Future<Result<List<JobApiModel>>> {
  Future<Result<List<Job>>> mapToEntity(List<JobCategoryApiModel> categories) =>
      mapFold(
        (jobs) => jobs.map((job) {
          if (categories.isEmpty) {
            return job._toEntityWith(null);
          }

          final jobCategory = categories.firstWhere(
            (cat) => cat.id == job.category, orElse: () => JobCategoryApiModel()
          );
          return job._toEntityWith(jobCategory);
        }).toList(),
        (error) => error,
      );
}

extension EntityParse on JobApiModel {
  Job _toEntityWith(JobCategoryApiModel? category) {
    late final DateTime date;
    final modelDate = this.date;
    if (modelDate != null) {
      date = DateTime.fromMillisecondsSinceEpoch(modelDate);
    } else {
      date = DateTime.now();
    }
    return Job(
      id: id,
      title: title ?? "Unknown",
      description: description ?? "Unknown",
      category: JobCategory(
        id: category?.id ?? "unknwon",
        name: category?.name ?? "Unkonwn",
      ),
      author: author ?? "Unknown",
      date: date,
    );
  }
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
      return Failure(
        JobFetchAllException(message: "error on fetch all categories"),
      );
    }

    final categories = categoriesResult.getOrNull();
    if (categories == null || categories.isEmpty) {
      return Failure(
        JobFetchAllException(message: "error on get categories, null or empty"),
      );
    }

    return dataSource.getAllJobs().mapToEntity(categories);
  }

  @override
  Future<Result<List<Job>>> getJobsByAuthor(String author) async {
    final categoriesResult = await categoryDataSource.getAllCategories();
    if (categoriesResult.isError()) {
      return Failure(
        JobFetchAllException(message: "error on fetch all categories"),
      );
    }

    final categories = categoriesResult.getOrNull();
    if (categories == null || categories.isEmpty) {
      return Failure(
        JobFetchAllException(message: "error on get categories, null or empty"),
      );
    }

    return dataSource.getJobsByAuthor(author).mapToEntity(categories);
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
