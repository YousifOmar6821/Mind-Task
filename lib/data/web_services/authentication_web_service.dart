import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/data/web_services/web_service.dart';
import '../../constants/strings.dart';

class AuthenticationWebService extends WebService {
  AuthenticationWebService() {
    dio.options.baseUrl = baseUrl;
  }
  Future<dynamic> login(String email, String password) async {
    try {
      Map<String,dynamic> header={
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };
      Options options = Options(headers: header);
      Response response = await dio.post('/login.php',
          options: options,
          data: FormData.fromMap({
            'email': email,
            'password': password,
            'token': 'asd342dsdddsd323dsdadasd3e',
            'platform': '1',
            'device_id': 'bfghtr5yrtytd654e6trd'
          }));
      return response.statusCode! == 200 && response.data['status'] == true&& response.data["msg"] == "success"
          ? response.data['data']?? (throw '')
          :throw getError(response);
    } on DioException catch (e, _) {
      if (e.response?.statusMessage?.toLowerCase().contains('timed out') ?? false) {
        throw DioException(requestOptions: RequestOptions(), type: DioExceptionType.connectionTimeout);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
  Future<dynamic> getUser(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.post('/patient/info');
      return response.statusCode! == 200 ? response.data['data'] : throw response.data['message'];
    } on DioException catch (e, _) {
      if (e.response?.statusMessage?.toLowerCase().contains('timed out') ?? false) {
        throw DioException(requestOptions: RequestOptions(), type: DioExceptionType.connectionTimeout);
      }
      throw e.response!.data['error'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}