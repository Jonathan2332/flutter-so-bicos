import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/core/data/repositories/job/job_category_repository.dart';
import 'package:so_bicos/core/domain/models/auth/errors.dart';
import 'package:so_bicos/core/domain/models/auth/user.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_category_errors.dart';
import 'package:so_bicos/ui/home/home_drawer_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_drawer_viewmodel.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>(as: #AuthRepositoryMock), MockSpec<JobCategoryRepository>(as: #JobCategoryRepositoryMock)])
import 'home_drawer_viewmodel_test.mocks.dart';

void main() {
  late final AuthRepositoryMock authRepository;
  late final JobCategoryRepositoryMock jobCategoryRepository;
  late final HomeDrawerViewModel viewModel;

  final nameTest = "Jonathan";
  final emailTest = "jonathan@gmail.com";
  final phoneNumberTest = "1234567";

  final user = User(
    name: nameTest,
    email: emailTest,
    phoneNumber: phoneNumberTest,
  );

  final jobCategory = JobCategory(
    id: "marketing_digital",
    name: "Marrketing digital",
  );

  setUpAll(() {
    authRepository = AuthRepositoryMock();
    jobCategoryRepository = JobCategoryRepositoryMock();
    viewModel = HomeDrawerViewModel(authRepository: authRepository, jobCategoryRepository: jobCategoryRepository);
  });

  group('loadUser', () {
    test('userViewState should be HomeUserSuccessState', () async {
      final Result<User> dummy = Success(user);
      provideDummy(dummy);

      when(authRepository.getLoggedUser()).thenAnswer((_) async => dummy);

      await viewModel.loadUser();

      expect(viewModel.userViewState.value, isA<HomeUserSuccessState>());
    });

    test('userViewState should be HomeDrawerErrorState', () async {
      final Result<User> dummy = Failure(LoggedUserException(message: ""));
      provideDummy(dummy);

      when(authRepository.getLoggedUser()).thenAnswer((_) async => dummy);

      await viewModel.loadUser();

      expect(viewModel.userViewState.value, isA<HomeDrawerErrorState>());
    });
  });

  group('loadCategories', () {
    test('categoryVIewState should be HomeJobCategorySuccessState', () async {
      final Result<List<JobCategory>> dummy = Success([jobCategory]);
      provideDummy(dummy);

      when(jobCategoryRepository.getAllCategories()).thenAnswer((_) async => dummy);

      await viewModel.loadCategories();

      expect(viewModel.categoriesViewState.value, isA<HomeJobCategorySuccessState>());
    });

    test('categoryVIewState should be HomeDrawerErrorState', () async {
      final Result<List<JobCategory>> dummy = Failure(CategoryFetchAllException(message: ""));
      provideDummy(dummy);

      when(jobCategoryRepository.getAllCategories()).thenAnswer((_) async => dummy);

      await viewModel.loadCategories();

      expect(viewModel.categoriesViewState.value, isA<HomeDrawerErrorState>());
    });
  });

  test('signout', () {
    when(authRepository.logout()).thenAnswer((_) async => {});
    expect(viewModel.signout(), completes);
  });

}
