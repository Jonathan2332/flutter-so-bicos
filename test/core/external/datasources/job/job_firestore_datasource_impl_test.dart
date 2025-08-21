import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/external/datasources/job/job_firestore_datasource_impl.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';

import '../../../../fakes/core/external/models/job/job_api_model_fake.dart';
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  DocumentSnapshot,
  QueryDocumentSnapshot,
  Query,
])
import 'job_firestore_datasource_impl_test.mocks.dart';

void main() {
  final firestore = MockFirebaseFirestore();

  final mockCollectionReference =
      MockCollectionReference<Map<String, dynamic>>();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

  final mockCollectionReferenceConverter =
      MockCollectionReference<JobApiModel>();

  final mockDocumentReferenceConverter = MockDocumentReference<JobApiModel>();

  final mockDocumentSnapshotConverter = MockDocumentSnapshot<JobApiModel>();
  final mockQuerySnapshot = MockQuerySnapshot<JobApiModel>();
  final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot<JobApiModel>();

  final dataSource = JobFirestoreDataSourceImpl(db: firestore);

  setUpAll(() {
    when(firestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(
      mockCollectionReference.add(any),
    ).thenAnswer((_) async => mockDocumentReference);
    when(
      mockDocumentReference.get(),
    ).thenAnswer((_) async => mockDocumentSnapshot);

    when(
      mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')),
    ).thenReturn(mockCollectionReference);

    when(
      mockCollectionReference.withConverter(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      ),
    ).thenReturn(mockCollectionReferenceConverter);

    when(
      mockDocumentReference.withConverter(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      ),
    ).thenReturn(mockDocumentReferenceConverter);

    when(
      mockCollectionReferenceConverter.get(),
    ).thenAnswer((_) async => mockQuerySnapshot);

    when(
      mockCollectionReferenceConverter.doc(any),
    ).thenReturn(mockDocumentReferenceConverter);
    when(
      mockCollectionReferenceConverter.add(any),
    ).thenAnswer((_) async => mockDocumentReferenceConverter);

    when(
      mockDocumentReferenceConverter.get(),
    ).thenAnswer((_) async => mockDocumentSnapshotConverter);

    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
  });

  group('getAllJobs', () {
    test('getAllJobs should be return list of JobApiModel', () async {
      final jobs = [
        {
          'id': '1',
          'title': 'Procuro alguém por',
          'description': 'Preciso de alguém',
          'category': 'marketing_digital',
          'author': 'teste@gmail.com',
          'date': '185961591565',
        },
        {
          'id': '2',
          'title': 'Procuro alguém para',
          'description': 'Preciso de alguém',
          'category': 'edicao_de_videos',
          'author': 'teste@gmail.com',
          'date': '159156529266',
        },
      ];

      final jobApiModelList = jobs
          .map(
            (job) => JobApiModel(
              title: job["title"],
              description: job["description"],
              category: job["category"],
              author: job["author"],
              date: int.tryParse(job["date"] ?? ""),
              id: int.tryParse(job["id"] ?? ""),
            ),
          )
          .toList();
      jobApiModelList.forEach(provideDummy);

      when(mockQuerySnapshot.size).thenReturn(jobs.length);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jobApiModelList.first);

      final result = await dataSource.getAllJobs();
      expect(result, isA<Result<List<JobApiModel>>>());
      expect(
        result.getOrNull()?.first.title,
        equals(jobApiModelList.first.title),
      );
    });

    test(
      'getAllJobs should be return an JobFetchAllException when size is 0',
      () async {
        provideDummy(jobApiModelFake);

        when(mockQuerySnapshot.size).thenReturn(0);

        final result = await dataSource.getAllJobs();
        expect(result, isA<Result<List<JobApiModel>>>());
        expect(result.exceptionOrNull(), isA<JobFetchAllException>());
        expect(result.isError(), true);
      },
    );
  });

  group('getJobsByAuthor', () {
    test(
      'getJobsByAuthor should be return Success list of JobApiModel',
      () async {
        final jobs = [
          {
            'id': '1',
            'title': 'Procuro alguém por',
            'description': 'Preciso de alguém',
            'category': 'marketing_digital',
            'author': 'teste@gmail.com',
            'date': '185961591565',
          },
          {
            'id': '2',
            'title': 'Procuro alguém para',
            'description': 'Preciso de alguém',
            'category': 'edicao_de_videos',
            'author': 'teste@gmail.com',
            'date': '159156529266',
          },
        ];

        final jobApiModelList = jobs
            .map(
              (job) => JobApiModel(
                title: job["title"],
                description: job["description"],
                category: job["category"],
                author: job["author"],
                date: int.tryParse(job["date"] ?? ""),
                id: int.tryParse(job["id"] ?? ""),
              ),
            )
            .toList();
        jobApiModelList.forEach(provideDummy);

        when(mockQuerySnapshot.size).thenReturn(jobs.length);
        when(
          mockQueryDocumentSnapshot.data(),
        ).thenReturn(jobApiModelList.first);

        final result = await dataSource.getJobsByAuthor("teste@gmail.com");
        expect(result, isA<Result<List<JobApiModel>>>());
        expect(
          result.getOrNull()?.first.title,
          equals(jobApiModelList.first.title),
        );
      },
    );

    test(
      'getJobsByAuthor should be return an JobFetchByAuthorException when author jobs is empty',
      () async {
        provideDummy(jobApiModelFake);

        when(mockQuerySnapshot.size).thenReturn(0);

        final result = await dataSource.getJobsByAuthor("teste@gmail.com");
        expect(result, isA<Result<List<JobApiModel>>>());
        expect(result.exceptionOrNull(), isA<JobFetchByAuthorException>());
        expect(result.isError(), true);
      },
    );
  });

  group('getJobsByCategoryId', () {
    test(
      'getJobsByCategoryId should be return Success list of JobApiModel',
      () async {
        final jobs = [
          {
            'id': '1',
            'title': 'Procuro alguém por',
            'description': 'Preciso de alguém',
            'category': 'marketing_digital',
            'author': 'teste@gmail.com',
            'date': '185961591565',
          },
          {
            'id': '2',
            'title': 'Procuro alguém para',
            'description': 'Preciso de alguém',
            'category': 'marketing_digital',
            'author': 'teste@gmail.com',
            'date': '159156529266',
          },
        ];

        final jobApiModelList = jobs
            .map(
              (job) => JobApiModel(
                title: job["title"],
                description: job["description"],
                category: job["category"],
                author: job["author"],
                date: int.tryParse(job["date"] ?? ""),
                id: int.tryParse(job["id"] ?? ""),
              ),
            )
            .toList();
        jobApiModelList.forEach(provideDummy);

        when(mockQuerySnapshot.size).thenReturn(jobs.length);
        when(
          mockQueryDocumentSnapshot.data(),
        ).thenReturn(jobApiModelList.first);

        final result = await dataSource.getJobsByCategoryId(
          "marketing_digital",
        );
        expect(result, isA<Result<List<JobApiModel>>>());
        expect(
          result.getOrNull()?.first.title,
          equals(jobApiModelList.first.title),
        );
      },
    );

    test(
      'getJobsByCategoryId should be return an JobFetchByCategoryException when category jobs is empty',
      () async {
        provideDummy(jobApiModelFake);

        when(mockQuerySnapshot.size).thenReturn(0);

        final result = await dataSource.getJobsByCategoryId("edicao_de_videos");
        expect(result, isA<Result<List<JobApiModel>>>());
        expect(result.exceptionOrNull(), isA<JobFetchByCategoryException>());
        expect(result.isError(), true);
      },
    );
  });
  group('publishJob', () {
    test('publishJob should return Result of void', () async {
      final result = await dataSource.publishJob(jobApiModelFake);
      expect(result, isA<Result<void>>());
    });

    test('publishJob should return an JobCreateException', () async {
      final result = await dataSource.publishJob(
        JobApiModel(
          id: null,
          title: null,
          description: null,
          category: null,
          author: null,
          date: null,
        ),
      );
      expect(result, isA<Result<void>>());
      expect(result.exceptionOrNull(), isA<JobCreateException>());
      expect(result.isError(), true);
    });
  });

  group('updateJob', () {
    test('updateJob should return Result of void', () async {
      final result = await dataSource.updateJob(jobApiModelFake);
      expect(result, isA<Result<void>>());
    });

    test('updateJob should return an JobCreateException', () async {
      final result = await dataSource.updateJob(
        JobApiModel(
          id: null,
          title: null,
          description: null,
          category: null,
          author: null,
          date: null,
        ),
      );
      expect(result, isA<Result<void>>());
      expect(result.exceptionOrNull(), isA<JobUpdateException>());
      expect(result.isError(), true);
    });
  });

  group('deleteJob', () {
    test('deleteJob should return Result of void', () async {
      final result = await dataSource.deleteJob(jobApiModelFake);
      expect(result, isA<Result<void>>());
    });

    test('deleteJob should return an JobDeleteException', () async {
      final result = await dataSource.deleteJob(
        JobApiModel(
          id: null,
          title: null,
          description: null,
          category: null,
          author: null,
          date: null,
        ),
      );
      expect(result, isA<Result<void>>());
      expect(result.exceptionOrNull(), isA<JobDeleteException>());
      expect(result.isError(), true);
    });
  });
}
