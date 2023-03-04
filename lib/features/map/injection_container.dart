import 'package:int20h/features/map/data/datasource/map_datasource.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';
import 'package:int20h/features/map/data/repositories/map_repository_impl.dart';
import 'package:int20h/features/map/presentation/cubit/map_add/map_add_cubit.dart';
import 'package:int20h/features/map/presentation/cubit/map_cubit.dart';
import 'package:int20h/injection_container.dart';
import 'package:dio/dio.dart';

mixin MapInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton(() => MapCubit(repository: sl()));
    sl.registerFactory(() => MapAddCubit(repository: sl()));

    // repositories
    sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(mapDatasource: sl(),));

    // data sources
    sl.registerLazySingleton<MapDatasource>(() => MapDatasourceImpl(dio: dio));

    // use case

  }
}
