import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class ApiManager {
  static late Dio _dio;
  static init() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    _dio = Dio()
      ..interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(documentDirectory.path),
          ),
        ),
      );
  }

  static get(String url, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(url, queryParameters: params);
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String?> getImageFile(String url, String id) async {
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      if (File(documentDirectory.path + '/$id.jpg').existsSync()) {
        return documentDirectory.path + '/$id.jpg';
      }
      Response response =
          await _dio.download(url, documentDirectory.path + '/$id.jpg');
      if (response.statusCode == 200) {
        return documentDirectory.path + '/$id.jpg';
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
