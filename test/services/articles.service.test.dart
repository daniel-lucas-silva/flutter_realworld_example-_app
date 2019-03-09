import 'package:test/test.dart';
import 'package:dio/dio.dart';
import 'package:realworld/services.dart';

void main() {
  // test('feed', () async {
  //   Response response;
  //   response = await articlesService.feed();
  //   expect(response.data["errCode"], 0);
  //   expect(response.headers != null, true);
  // });

  test('all', () async {
    Response response;
    response = await articlesService.all();
    // print(response);
    expect(response.data["errCode"], 0);
    expect(response.headers != null, true);
  });

  test('byAuthor', () async {
    Response response;
    response = await articlesService.byAuthor('dannlks');
    // print(response);
    expect(response.data["errCode"], 0);
    expect(response.headers != null, true);
  });

  test('byTag', () async {
    Response response;
    response = await articlesService.byTag('test');
    // print(response);
    expect(response.data["errCode"], 0);
    expect(response.headers != null, true);
  });
}
