/// What does the class depends on
/// Answer -- Authentication Repository
/// How can we create a fake version of the dependency
/// Answer -- Use Mocktail package
/// How do we control what our dependencies do
/// Answer -- Using the mocktail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_demo/src/authentication/domain/entities/user.dart';
import 'package:tdd_demo/src/authentication/domain/useCases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late MockAuthenticationRepository repository;
  late GetUsers useCase;
  const tResponse = [User.empty()];
  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = GetUsers(repository);
  });

  test(
    'should call [AuthRepo.getUsers and return List<User>]',
    () async {
      /// Arrange
      when(() => repository.getUsers()).thenAnswer(
        (invocation) async => const Right(tResponse),
      );

      /// Act
      final result = await useCase();

      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

      verify(() => repository.getUsers()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
