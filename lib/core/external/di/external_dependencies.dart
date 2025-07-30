import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:so_bicos/core/data/datasources/auth/auth_datasource.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/external/datasources/auth/firebase_datasource_impl.dart';
import 'package:so_bicos/core/external/datasources/job/category_firestore_datasource_impl.dart';

List<SingleChildWidget> get externalDependencies {
  return [
    Provider(create: (context) => FirebaseAuth.instance),
    Provider(create: (context) => FirebaseFirestore.instance),
    Provider(create: (context) => FirebaseDataSourceImpl(auth: context.read()) as AuthDataSource),
    Provider(create: (context) => CategoryFirestoreDataSourceImpl(db: context.read()) as JobCategoryDataSource),
  ];
}