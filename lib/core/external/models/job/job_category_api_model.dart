// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobCategoryApiModel {
  String? name;
  JobCategoryApiModel({
    this.name,
  });

  JobCategoryApiModel copyWith({
    String? name,
  }) {
    return JobCategoryApiModel(
      name: name ?? this.name,
    );
  }
}
