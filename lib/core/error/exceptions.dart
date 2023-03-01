
import 'package:dio/dio.dart';
import 'package:int20h/core/models/server_error.dart';
import 'package:int20h/core/network/network_info.dart';
import 'package:int20h/injection_container.dart';

import 'failures.dart';

Future<Failure> errorHandler(Object error, Failure? defaultFailure) async {
  try {
    print(error);
    if (error is DioError) {
      //print(error.response?.data);
      if (error.response != null) {
        String? serverError = error.response?.data['errorMessage'];
        return Failure(
            errorMessage: serverError ??
                "Sorry, we cannot process your request at the moment. Please contact the support team. ");
      }
    }

    NetworkInfo networkInfo = sl();
    if (!(await networkInfo.isConnected)) {
      return InternetConnectionFailure();
    }

    return defaultFailure!;
  } catch (err) {
    return Failure();
  }
}

class ServerException implements Exception {}

class CacheException implements Exception {}

class GetTokenException implements Exception {}
