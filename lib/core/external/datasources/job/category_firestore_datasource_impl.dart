// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_category_errors.dart';

class CategoryFirestoreDataSourceImpl implements JobCategoryDataSource {
  final FirebaseFirestore db;
  final categoriesPath = "categories";

  CategoryFirestoreDataSourceImpl({required this.db});

  @override
  Future<Result<List<JobCategoryApiModel>>> getAllCategories() async {
    final ref = db
        .collection(categoriesPath)
        .withConverter(
          fromFirestore: JobCategoryApiModel.fromFirestore,
          toFirestore: (jobCategory, options) => jobCategory.toFirestore(),
        );

    final snapshot = await ref.get();
    if (snapshot.size > 0) {
      return Success(snapshot.docs.map((e) => e.data()).toList());
    } else {
      return Failure(
        CategoryFetchAllException(
          message: "Error on get all categories, size is empty",
        ),
      );
    }
  }

  @override
  Future<Result<JobCategoryApiModel>> getCategoryById(String id) async {
    
    final ref = db.collection(categoriesPath).doc(id);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      return Success(JobCategoryApiModel.fromFirestore(snapshot, null));
    } else {
      return Failure(
        CategoryFetchByIdException(
          message: "Error on get all categories, size is empty",
        ),
      );
    }
  }
}
