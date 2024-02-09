import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_demo/src/authentication/data/dataSouces/authentication_remote_data_source.dart';
import 'package:tdd_demo/src/authentication/data/repositories/authentication_repository_implementation.dart';

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

  group('createUser', () {
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
      const createdAt = 'whatEver.createdAt';
      const name = 'whatEver.name';
      const avatar = 'whatEver.avatar';

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
      'should return a [ServerFailure] when the call to the remote source is unsuccessful',
      () async {
        /// Arrange
        when(
              () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow((_) async => Future.value());
      },
    );
  });
}
