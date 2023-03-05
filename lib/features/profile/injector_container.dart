import 'package:int20h/features/profile/domain/use_cases/get_user_usecase.dart';
import 'package:int20h/features/profile/data/datasource/profile_datasource.dart';
import 'package:int20h/features/profile/domain/repositories/profile_repository.dart';
import 'package:int20h/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:int20h/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:int20h/injection_container.dart';
import 'package:dio/dio.dart';

mixin ProfileInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton(() => UserCubit(repository: sl()));

    // repositories
    sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
          profileDatasource: sl(),
        ));

    // data sources
    sl.registerLazySingleton<ProfileDatasource>(
        () => ProfileDatasourceImpl(dio: dio));

    // use case
    sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));
  }
}
