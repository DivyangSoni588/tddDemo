import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_demo/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:tdd_demo/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_demo/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_demo/src/authentication/domain/useCases/create_user.dart';
import 'package:tdd_demo/src/authentication/domain/useCases/get_users.dart';
import 'package:tdd_demo/src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //APP LOGIC
    ..registerFactory(
      () => AuthenticationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )
    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // Repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    //DataSources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImplementation(sl()))
    // External dependencies
    ..registerLazySingleton(http.Client.new);
}
