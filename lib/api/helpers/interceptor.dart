import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/utils/keys.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;
  final SharedPref _sharedPref = SharedPref();
  final Dio dio;

  LoggingInterceptors({required this.dio});

  Future<String> getToken() async {
    var token = await _sharedPref.readString("token") ?? "";
    return token;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await getToken().then((value) {
      if (value.isNotEmpty) {
        options.headers.addAll({"Authorization": value});
      }
      debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
      debugPrint("Content type: ${options.contentType}");
      debugPrint("QueryParams: ${options.queryParameters}");
      debugPrint("Headers: ${options.headers}");
      debugPrint("Data: ${options.data}");
      return super.onRequest(options, handler);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("<-- STATUS : ${response.statusCode}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint(response.data.toString());
    }
    debugPrint("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    if (err.response!.statusCode == 401) {
      _sharedPref.remove('isLoggedIn');
      var currentContext =
          GlobalVariableKeys.navigatorState.currentState!.context;
      Navigator.pushNamed(currentContext, Routes.loginScreen);
    }
    /* if (error.response!.statusCode == 401) {
      String refreshToken =
          await _sharedPref.readString("apiRefreshToken") ?? "";
      if (refreshToken.isNotEmpty) {
        Dio tokenDio = Dio();
        Options options = Options(
            method: error.requestOptions.method,
            sendTimeout: error.requestOptions.sendTimeout,
            receiveTimeout: error.requestOptions.receiveTimeout,
            extra: error.requestOptions.extra,
            headers: error.requestOptions.headers,
            responseType: error.requestOptions.responseType,
            contentType: error.requestOptions.contentType);
        tokenDio.interceptors.add(LogInterceptor(
            responseBody: true,
            requestHeader: false,
            requestBody: false,
            request: false,
            responseHeader: false));
        return await tokenDio.post(
            "https://v3stage.getalice.ai/api/accounts/refresh",
            data: {'refresh': refreshToken}).then((data) {
          //update Token
          error.requestOptions.headers["Authorization"] =
              "Token " + data.data["access"];
          _sharedPref.saveString("apiToken", data.data["access"]);
        }).catchError((e) {
          if (e is DioError) {
            if (e.response!.statusCode == 401) {
              _sharedPref.clear();
              // pref.Get.offAllNamed(LOGIN_PAGE);
            }
          }
        }).then((value) async {
          //repeat
          final response = await tokenDio.request(
              error.requestOptions.baseUrl + error.requestOptions.path,
              data: error.requestOptions.data,
              cancelToken: error.requestOptions.cancelToken,
              onReceiveProgress: error.requestOptions.onReceiveProgress,
              onSendProgress: error.requestOptions.onSendProgress,
              queryParameters: error.requestOptions.queryParameters,
              options: options);

          return handler.resolve(response);
        });
      } else {
        return super.onError(error, handler);
      }
    } else */
    return super.onError(err, handler);
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;

  //final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    // required this.connectivity,
  });

/*  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {

    var streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        log(connectivityResult);
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(dio.request(
            requestOptions.baseUrl + requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
                method: requestOptions.method,
                sendTimeout: requestOptions.sendTimeout,
                receiveTimeout: requestOptions.receiveTimeout,
                extra: requestOptions.extra,
                headers: requestOptions.headers,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType),
          ));
        }
      },
    );
    return responseCompleter.future;
  } */
}
