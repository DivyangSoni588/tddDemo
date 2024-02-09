import 'package:dartz/dartz.dart';
import 'package:tdd_demo/core/utils/typedef.dart';
import 'package:tdd_demo/src/authentication/data/dataSouces/authentication_remote_data_source.dart';
import 'package:tdd_demo/src/authentication/domain/entities/user.dart';
import 'package:tdd_demo/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // Test-Driven Development
    // call the remote dataSource
    // check whether method returns the proper data
    // // check if when the remoteDataSource throws an exception, we return a failure
    // // and if it doesn't throw an exception, we return the actual expected data
    await _remoteDataSource.createUser(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    );
    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
