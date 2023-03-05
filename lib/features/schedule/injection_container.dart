import 'package:dio/dio.dart';
import 'package:int20h/features/schedule/data/datasource/schedule_datasource.dart';
import 'package:int20h/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:int20h/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:int20h/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:int20h/injection_container.dart';

mixin ScheduleInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton(
        () => ScheduleCubit(repository: sl(), mapRepository: sl()));

    // repositories
    sl.registerLazySingleton<ScheduleRepository>(() => ScheduleRepositoryImpl(
          scheduleDatasource: sl(),
        ));

    // data sources
    sl.registerLazySingleton<ScheduleDatasource>(
        () => ScheduleDatasourceImpl(dio: dio));
  }
}
