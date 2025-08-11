// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class JobCategoryApiModel {
  String? id;
  String? name;
  JobCategoryApiModel({this.id, this.name});

  JobCategoryApiModel copyWith({String? id, String? name}) {
    return JobCategoryApiModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory JobCategoryApiModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return JobCategoryApiModel(id: snapshot.id, name: data?['name']);
  }

  Map<String, dynamic> toFirestore() {
    return {if (id != null) "id": id, if (name != null) "name": name};
  }
}
