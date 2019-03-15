import 'package:dio/dio.dart' show Dio;
import 'package:realworld/constants.dart' show APIURL;

class Request {
  final Dio dio = Dio();

  auth(token) {
    request.dio.options.headers = {'Authorization': 'Token $token'};
  }

  get(String url) async {
    try {
      return await dio.get("$APIURL/$url");
    } catch (e) {
      throw (e);
    }
  }

  post(String url, {data}) async {
    try {
      return await dio.post("$APIURL/$url", data: data);
    } catch (e) {
      throw (e);
    }
  }

  put(String url, {data}) async {
    try {
      return await dio.put("$APIURL/$url", data: data);
    } catch (e) {
      throw (e);
    }
  }

  delete(String url) async {
    try {
      return await dio.delete("$APIURL/$url");
    } catch (e) {
      throw (e);
    }
  }
}

final Request request = Request();
