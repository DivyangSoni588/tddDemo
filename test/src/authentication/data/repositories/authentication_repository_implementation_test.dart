import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_demo/core/errors/exceptions.dart';
import 'package:tdd_demo/core/errors/failure.dart';
import 'package:tdd_demo/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:tdd_demo/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_demo/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown error occurred',
    statusCode: 500,
  );

  group(
    'createUser',
    () {
      const createdAt = 'whatEver.createdAt';
      const name = 'whatEver.name';
      const avatar = 'whatEver.avatar';
      test(
          'should call the remote [RemoteDataSource.createUser] and complete successfully'
          'when the call to the remote source is successful', () async {
        /// Arrange
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((invocation) async => Future.value());

        /// Act
        final result = await repositoryImplementation.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        /// Assert
        expect(result, const Right(null));
        verify(() => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      });

      test(
        'should return a [APIFailure] when the call to the remote source is unsuccessful',
        () async {
          /// Arrange
          when(
            () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenThrow(
            tException,
          );

          final result = await repositoryImplementation.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          );

          expect(
              result,
              equals(Left(
                APIFailure(
                  message: tException.message,
                  statusCode: tException.statusCode,
                ),
              )));

          verify(
            () => remoteDataSource.createUser(
                createdAt: createdAt, name: name, avatar: avatar),
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );

  group(
    'get users',
    () {
      test(
        'should call the [RemoteDataSource.getUsers] and return a list of users'
        'when call to the remote source successful',
        () async {
          when(() => remoteDataSource.getUsers()).thenAnswer(
            (_) async => [],
          );

          final result = await repositoryImplementation.getUsers();

          expect(result, isA<Right<dynamic, List<User>>>());

          verify(() => remoteDataSource.getUsers()).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should return a [APIFailure] when the call to the remote source is unsuccessful',
        () async {
          when(() => remoteDataSource.getUsers()).thenThrow(tException);

          final result = await repositoryImplementation.getUsers();

          expect(
            result,
            equals(
              Left(
                APIFailure(
                    message: tException.message,
                    statusCode: tException.statusCode),
              ),
            ),
          );
        },
      );
    },
  );
}
