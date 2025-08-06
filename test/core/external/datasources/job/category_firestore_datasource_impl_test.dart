import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/external/datasources/job/category_firestore_datasource_impl.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_category_errors.dart';

import '../../../../fakes/core/external/models/jobs/job_category_api_model_fake.dart';
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  DocumentSnapshot,
  QueryDocumentSnapshot,
  Query,
])
import 'category_firestore_datasource_impl_test.mocks.dart';

void main() {
  final firestore = MockFirebaseFirestore();

  final mockCollectionReference =
      MockCollectionReference<Map<String, dynamic>>();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

  final mockCollectionReferenceConverter =
      MockCollectionReference<JobCategoryApiModel>();

  final mockDocumentReferenceConverter =
      MockDocumentReference<JobCategoryApiModel>();

  final mockDocumentSnapshotConverter =
      MockDocumentSnapshot<JobCategoryApiModel>();
  final mockQuerySnapshot = MockQuerySnapshot<JobCategoryApiModel>();
  final mockQueryDocumentSnapshot =
      MockQueryDocumentSnapshot<JobCategoryApiModel>();

  final dataSource = CategoryFirestoreDataSourceImpl(db: firestore);

  setUpAll(() {
    when(firestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(
      mockDocumentReference.get(),
    ).thenAnswer((_) async => mockDocumentSnapshot);

    when(
      mockCollectionReference.withConverter(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      ),
    ).thenReturn(mockCollectionReferenceConverter);

    when(
      mockCollectionReferenceConverter.get(),
    ).thenAnswer((_) async => mockQuerySnapshot);

    when(
      mockCollectionReferenceConverter.doc(any),
    ).thenReturn(mockDocumentReferenceConverter);
    when(
      mockDocumentReferenceConverter.get(),
    ).thenAnswer((_) async => mockDocumentSnapshotConverter);
    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
  });

  group('getAllCategories', () {
    test(
      'getAllCategories should be return list of JobCategoryApiModel',
      () async {
        final categories = [
          {'name': 'Marketing digital'},
          {'name': 'Edição de vídeos'},
        ];

        final jobCategoryApiModelList = categories
            .map((category) => JobCategoryApiModel(name: category["name"]))
            .toList();
        jobCategoryApiModelList.forEach(provideDummy);

        when(mockQuerySnapshot.size).thenReturn(categories.length);
        when(
          mockQueryDocumentSnapshot.data(),
        ).thenReturn(jobCategoryApiModelList.first);

        final result = await dataSource.getAllCategories();
        expect(result, isA<Result<List<JobCategoryApiModel>>>());
        expect(
          result.getOrNull()?.first.name,
          equals(jobCategoryApiModelList.first.name),
        );
      },
    );

    test(
      'getAllCategories should be return an CategoryFetchAllException when size is 0',
      () async {
        provideDummy(JobCategoryApiModel(name: ""));

        when(mockQuerySnapshot.size).thenReturn(0);

        final result = await dataSource.getAllCategories();
        expect(result, isA<Result<List<JobCategoryApiModel>>>());
        expect(result.exceptionOrNull(), isA<CategoryFetchAllException>());
        expect(result.isError(), true);
      },
    );
  });

  group('getCategoryById', () {
    test('getCategoryById should be return JobCategoryApiModel', () async {
      final category = {'id': 'marketing_digital', 'name': 'Marketing digital'};
      provideDummy(jobCategoryApiModelFake);

      when(mockDocumentSnapshot.id).thenReturn(category['id']!);
      when(mockDocumentSnapshot.exists).thenReturn(true);

      when(mockDocumentSnapshot.data()).thenReturn(category);

      final result = await dataSource.getCategoryById(
        jobCategoryApiModelFake.id!,
      );
      expect(result, isA<Result<JobCategoryApiModel>>());
      expect(result.getOrNull()?.id, equals(jobCategoryApiModelFake.id));
    });

    test(
      'getCategoryById should be return an CategoryFetchByIdException when category not exists',
      () async {
        when(mockDocumentSnapshot.exists).thenReturn(false);

        final result = await dataSource.getCategoryById("e");
        expect(result, isA<Result<JobCategoryApiModel>>());
        expect(result.exceptionOrNull(), isA<CategoryFetchByIdException>());
        expect(result.isError(), true);
      },
    );
  });
}
