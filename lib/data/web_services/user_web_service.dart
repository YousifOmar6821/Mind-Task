import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/data/local/global_settings.dart';
import 'package:task/data/models/product.dart';
import 'package:task/data/web_services/web_service.dart';

import '../../constants/strings.dart';

class UserWebService extends WebService {
  UserWebService() {
    dio.options.baseUrl = baseUrl;
  }

  Future<dynamic> getHomeData() async {
    try {
      Map<String,dynamic> header={
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Accept-Language': GlobalSettings.appSettings.languageCode,
      };
      Options options = Options(headers: header);
      Response response = await dio.post('/home/home.php',
          options: options,
          data: FormData.fromMap({
            'auth_key': GlobalSettings.user!.authKey,
            'user_id': GlobalSettings.user!.id,
          }));
      return response.statusCode! == 200 && response.data['status'] == true&& response.data["msg"] == "success"
          ? response.data['data']?? (throw '')
          :throw getError(response);
    } on DioException catch (e, _) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw e.response!.data['message'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<dynamic> getMoreProductsData(String productType,String searchKeyWord) async {
    try {
      Map<String,dynamic> header={
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Accept-Language': GlobalSettings.appSettings.languageCode,
      };
      Options options = Options(headers: header);
      Response response = await dio.post('/products/search_filter.php',
          options: options,
          data: FormData.fromMap({
            'auth_key': GlobalSettings.user!.authKey,
            'user_id': GlobalSettings.user!.id,
            'search_with': searchKeyWord,
            'home_types': productType,
            'item_count': 0,
            'limit': 30,
          }));
      return response.statusCode! == 200 && response.data['status'] == true&& response.data["msg"] == "success"
          ? response.data['data']?? (throw '')
          :throw getError(response);
    } on DioException catch (e, _) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw e.response!.data['message'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}