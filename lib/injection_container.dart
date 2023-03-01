import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:int20h/features/profile/injector_container.dart';
import 'package:int20h/features/sign_up/injection_container.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_config.dart';
import 'core/interceptors/error_logger_interceptor.dart';
import 'core/network/network_info.dart';
import 'features/bottom_nav_bar/injection_container.dart';

final sl = GetIt.instance;

const globalDio = 'global';

class InjectionContainer extends Injector with AuthInjector, ProfileInjector, BottomNavBarInjector{}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    // final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    sl.registerLazySingleton<AppConfig>(() => AppConfig.init);

    sl.registerLazySingleton<Dio>(
      () {
        final dio = Dio(BaseOptions(
          baseUrl: sl<AppConfig>().api,
          connectTimeout: 15000,
          receiveTimeout: 15000,
        ));
        dio.options.headers = {
          "content-type": "application/json",
          "Accept": "application/json",
          // "App-Timezone": currentTimeZone
        };
        dio.interceptors.add(ErrorLoggerInterceptor());
        if (!sl<AppConfig>().isProductionEnvironment) {
          dio.interceptors.add(PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ));
        }
        return dio;
      },
      instanceName: globalDio,
    );

    //Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    //External
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
