import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';

@GenerateNiceMocks([MockSpec<JobDataSource>()])
import 'job_repository_impl_test.mocks.dart';

void main() {
  final dataSource = MockJobDataSource();

  group("getAllJobs", () {
    test('getAllJobs', () async {
      // TODO: Implement test
    });
  });
}
