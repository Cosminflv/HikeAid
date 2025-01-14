import 'package:core/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:openapi/openapi.dart';

void main() {
  late LoginApi loginApi;

  setUp(() {
    Dio dio = Dio(BaseOptions(baseUrl: "http://$ipv4Address:7011/", connectTimeout: Duration(seconds: 10)));

    dio.options.validateStatus = (status) {
      // Allow all status codes from 200 to 499 as valid
      return status != null && status >= 200 && status < 500;
    };

    final openApi = Openapi(dio: dio, interceptors: [BearerAuthInterceptor()]);
    loginApi = openApi.getLoginApi();
  });

  test('getAllCategories calls method on repository', () async {
    // Act
    final result = await loginApi.apiLoginLoginPost(
      loginDto: LoginDto(
        (builder) {
          builder.username = "Cosbos";
          builder.password = "qaz123//";
        },
      ),
    );

    expect(result.statusCode, 200);
  });
}
