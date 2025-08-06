import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/core/domain/models/auth/errors.dart';
import 'package:so_bicos/core/domain/models/auth/user.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>(as: #AuthRepositoryMock)])
import 'home_viewmodel_test.mocks.dart';

void main() {
  late final AuthRepositoryMock repository;
  late final HomeViewModel viewModel;

  final nameTest = "Jonathan";
  final emailTest = "jonathan@gmail.com";
  final phoneNumberTest = "1234567";

  final user = User(
    name: nameTest,
    email: emailTest,
    phoneNumber: phoneNumberTest,
  );

  setUpAll(() {
    repository = AuthRepositoryMock();
    viewModel = HomeViewModel(authRepository: repository);
  });

  group('load', () {
    test('ViewState should be HomeSuccessState', () async {
      final Result<User> dummy = Success(user);
      provideDummy(dummy);

      when(repository.getLoggedUser()).thenAnswer((_) async => dummy);

      await viewModel.load();

      expect(viewModel.viewState.value, isA<HomeSuccessState>());
    });

    test('ViewState should be HomeErrorState', () async {
      final Result<User> dummy = Failure(LoggedUserException(message: ""));
      provideDummy(dummy);

      when(repository.getLoggedUser()).thenAnswer((_) async => dummy);

      await viewModel.load();

      expect(viewModel.viewState.value, isA<HomeErrorState>());
    });
  });

  test('signout', () {
    when(repository.logout()).thenAnswer((_) async => {});
    expect(viewModel.signout(), completes);
  });
}
