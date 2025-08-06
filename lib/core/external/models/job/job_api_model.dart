// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class JobApiModel {
  int? id;
  String? title;
  String? description;
  String? category;
  String? author;
  int? date;

  JobApiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.author,
    required this.date,
  });

  JobApiModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? author,
    int? date,
  }) {
    return JobApiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
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
      id: data?['id'],
      title: data?['title'],
      description: data?["description"],
      category: data?["category"],
      author: data?["author"],
      date: data?["date"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (category != null) "category": category,
      if (author != null) "author": author,
      if (date != null) "date": date,
    };
  }
}
