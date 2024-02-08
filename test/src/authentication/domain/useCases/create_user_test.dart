/// What does the class depends on
/// Answer -- Authentication Repository
/// How can we create a fake version of the dependency
/// Answer -- Use Mocktail package
/// How do we control what our dependencies do
/// Answer -- Using the mocktail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_demo/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_demo/src/authentication/domain/useCases/create_user.dart';

import 'authentication_repository.mock.dart';



void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;
  const params = CreateUserParams.empty();
  setUpAll(() {
    repository = MockAuthenticationRepository();
    useCase = CreateUser(repository);
  });
  test(
    'should call the [Repository.createUser]',
    () async {
      /// Arrange
      /// STUB
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      /// Act
      final result = await useCase(params);

      /// Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar,
          )).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
