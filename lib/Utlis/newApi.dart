import 'package:dio/dio.dart';

import '../constants/global.dart';

class NewAPI {
  final Dio _dio = Dio();

  NewAPI() {
    _dio.options.baseUrl = Global.hostUrl;
  }

  Dio get sendRequest => _dio;
}
