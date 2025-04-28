import 'package:chat_gpt_sdk_lululala/src/utils/token_builder.dart';
import 'package:dio/dio.dart';

import '../../utils/constants.dart';

class InterceptorWrapper extends Interceptor {
  final String token;
  final String? orgId;

  InterceptorWrapper({
    required this.token,
    this.orgId,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(
      kHeader(
        token,
        orgId,
      ),
    );

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //debugPrint('http status code => ${response.statusCode} \nresponse data => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}
