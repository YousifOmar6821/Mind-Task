import 'package:dio/dio.dart';

import '../local/global_settings.dart';

abstract class WebService {
  late Dio dio;

  WebService() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      // validateStatus: (status) => true,
      followRedirects: true,
      maxRedirects: 5,
    );
    dio = Dio(options);
  }

  String getError(Response response) {
    if ((response.data['error'] ?? '') is String) {
      return GlobalSettings.isEn
          ? response.data['error']??''
          : response.data['errorAr']??'';
    } else {
      return GlobalSettings.isEn
          ? (response.data['error'] as Map).values.elementAt(0)[0]??''
          : (response.data['errorAr'] as Map).values.elementAt(0)[0]??'';
    }
  }
  String getMsg(Response response) {
    return GlobalSettings.isEn
        ? response.data['message']??''
        : response.data['messageAr']??'';
  }
}
