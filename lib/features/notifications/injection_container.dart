import 'package:int20h/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:int20h/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:int20h/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:int20h/injection_container.dart';
import 'package:dio/dio.dart';

import 'domain/repositories/notifications_repository.dart';

mixin NotificationsInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton(() => NotificationCubit(repository: sl()));

    // repositories
    sl.registerLazySingleton<NotificationsRepository>(
        () => NotificationsRepositoryImpl(
              notificationsDatasource: sl(),
            ));

    // data sources
    sl.registerLazySingleton<NotificationsDatasource>(
        () => NotificationsDatasourceImpl(dio: dio));

    // use case
  }
}
