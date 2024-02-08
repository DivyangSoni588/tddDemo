import 'package:tdd_demo/core/useCase/useCase.dart';
import 'package:tdd_demo/core/utils/typedef.dart';
import 'package:tdd_demo/src/authentication/domain/entities/user.dart';
import 'package:tdd_demo/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
