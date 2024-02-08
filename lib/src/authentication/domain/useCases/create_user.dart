import 'package:equatable/equatable.dart';
import 'package:tdd_demo/core/useCase/useCase.dart';
import 'package:tdd_demo/core/utils/typedef.dart';
import 'package:tdd_demo/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async =>
      _repository.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

  @override
  ResultFuture call(CreateUserParams params) => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty() : this(createdAt: '', avatar: '', name: '');

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
