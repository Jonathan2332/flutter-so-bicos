// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class JobCategoryApiModel {
  String? name;
  JobCategoryApiModel({this.name});

  JobCategoryApiModel copyWith({String? name}) {
    return JobCategoryApiModel(name: name ?? this.name);
  }

  factory JobCategoryApiModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return JobCategoryApiModel(name: data?['name']);
  }

  Map<String, dynamic> toFirestore() {
    return {if (name != null) "name": name};
  }
}
