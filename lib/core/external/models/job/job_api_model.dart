// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class JobApiModel {
  String? title;
  String? description;
  String? author;
  int? date;

  JobApiModel({
    required this.title,
    required this.description,
    required this.author,
    required this.date,
  });

  JobApiModel copyWith({
    String? title,
    String? description,
    String? author,
    int? date,
  }) {
    return JobApiModel(
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      date: date ?? this.date,
    );
  }

  factory JobApiModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return JobApiModel(
      title: data?['title'],
      description: data?["description"],
      author: data?["author"],
      date: data?["date"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (author != null) "author": author,
      if (date != null) "date": date,
    };
  }
}
