// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class JobCategoryErrors implements Exception {}

class CategoryFetchAllException extends JobCategoryErrors {
  String message;
  CategoryFetchAllException({required this.message});
}
