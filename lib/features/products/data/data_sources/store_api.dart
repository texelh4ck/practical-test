import 'package:dio/dio.dart';

class StoreApi {
  Dio dio = Dio();

  Future<Response> getProducts({int page = 0}) async {
    final resp = await dio.get("https://fakestoreapi.com/products");
    return resp;
  }
}
