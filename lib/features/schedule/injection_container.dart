import 'package:int20h/injection_container.dart';
import 'package:dio/dio.dart';

mixin ScheduleInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    //sl.registerFactory(() => Cubit(repository: sl()));

    // repositories

    // data sources

    // use case

  }
}
