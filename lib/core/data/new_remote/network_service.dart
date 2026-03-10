import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:task_management_system/application/auth/screens/login_screen.dart';
import 'package:task_management_system/core/data/local_data/shared_pref.dart';
import 'package:task_management_system/core/data/new_remote/response_model.dart';
import 'package:task_management_system/core/data/new_remote/server_config.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/core/values/constant.dart';
import 'package:task_management_system/main.dart';
import '../../utils/functions.dart';

enum HttpMethod { get, post, delete, put }

enum BodyType { json, formData }

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

abstract class NetworkService {
  static Future<T> handleResponse<T>(
    response, {
    T Function(dynamic data)? successCallback,
    T Function(String error)? errorCallback,
  }) async {
    ResponseModel res = ResponseModel.fromJson(response.data);
    int statusCode = response.statusCode ?? 0;
    if (response.headers["authorization"]?[0] != null) {
      setValue(TOKEN, response.headers["authorization"]?[0]);
    }
    switch (statusCode) {
      case 200:
        return successCallback!(res);

      case 400:
        return errorCallback!(language.invalidRequestCheckInput);

      case 401:
        return errorCallback!(language.unauthorizedPleaseLoginAgain);

      case 403:
        return errorCallback!(language.accessDeniedNoPermission);

      case 404:
        return errorCallback!(language.notFound);

      case 500:
        return errorCallback!(language.serverErrorTryAgainLater);
      default:
        if (statusCode >= 200 && statusCode < 300) {
          return successCallback!(res);
        } else if (statusCode >= 400 && statusCode < 500) {
          return errorCallback!(language.requestFailed);
        } else if (statusCode >= 500) {
          return errorCallback!(language.serverErrorTryAgainLater);
        } else {
          return errorCallback!(language.unexpectedErrorOccurred);
        }
    }
  }

  Uri buildRequestUrl(String endPoint) {
    Uri url = Uri.parse(endPoint);
    if (!endPoint.startsWith('http')) {
      url = Uri.parse('${'http://192.168.1.207:8006/'}$endPoint');
    }
    return url;
  }

  Future sendRequest(
    String endPoint, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? body,
    BodyType bodyType,
    Map<String, String>? queryParameters,
  });
}

class DioNetworkService extends NetworkService {
  Dio dio = Dio();

  @override
  Future sendRequest(
    String endPoint, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? body,
    BodyType bodyType = BodyType.json,
    Map<String, String>? queryParameters,
  }) async {
    dio.options.baseUrl = ServerConfig.baseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.sendTimeout = const Duration(seconds: 20);
    dio.options.connectTimeout = const Duration(seconds: 20);
    if (getStringAsync(TOKEN).isNotEmpty) {
      dio.options.headers.addAll({'Authorization': getStringAsync(TOKEN)});
    }

    /*if (!await NetworkStateDetector().isWiFiEnabled()) {
      toast(language.checkYourInternetConnection);
      throw NetworkException(language.noInternetConnection);
    }*/

    try {
      dio.options.headers.addAll(
        bodyType == BodyType.formData
            ? {HttpHeaders.contentTypeHeader: "multipart/form-data"}
            : {HttpHeaders.contentTypeHeader: "application/json"},
      );

      Response response;
      switch (method) {
        case HttpMethod.get:
          response = await dio.get(queryParameters: queryParameters, endPoint);
          break;

        case HttpMethod.post:
          response = await dio.post(
            queryParameters: queryParameters,
            endPoint,
            data: getBody(body, bodyType),
          );
          break;

        case HttpMethod.put:
          response = await dio.put(
            queryParameters: queryParameters,
            endPoint,
            data: getBody(body, bodyType),
          );
          break;

        case HttpMethod.delete:
          response = await dio.delete(queryParameters: queryParameters, endPoint);
          break;
      }

      Functions.printNormal(
        'Response (${method.name}) ${response.statusCode}: ${response.data.toString()}',
      );

      return NetworkService.handleResponse<ResponseModel>(
        response,
        successCallback: (data) => data,
        errorCallback: (error) => throw NetworkException(error, statusCode: response.statusCode),
      );
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      if (e is NetworkException) {
        rethrow;
      }
      throw NetworkException('${language.unexpectedError}: $e');
    }
  }

  NetworkException handleDioError(DioException error) {
    String message;
    int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = language.connectionTimeoutCheckInternet;
        break;

      case DioExceptionType.sendTimeout:
        message = language.requestTimeoutTryAgain;
        break;

      case DioExceptionType.receiveTimeout:
        message = language.serverTimeoutTryAgain;
        break;

      case DioExceptionType.badResponse:
        try {
          ResponseModel res = ResponseModel.fromJson(error.response?.data);
          message = ((res.message != null && res.message!.isNotEmpty) ? res.message : language.requestFailed)!;
        } catch (_) {
          message = language.requestFailed;
        }
        break;

      case DioExceptionType.cancel:
        message = language.requestWasCancelled;
        break;

      case DioExceptionType.connectionError:
        message = language.noInternetCheckNetwork;
        break;

      case DioExceptionType.badCertificate:
        message = language.securityCertificateError;
        break;

      case DioExceptionType.unknown:
        message = language.networkErrorTryAgain;
        break;
    }

    if (statusCode == 401) {
      setValue(TOKEN, '');
      const LoginScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
      Functions.printError('Unauthorized - User logged out');
    }

    Functions.printError('DioError: $message (Status: $statusCode)');
    return NetworkException(message, statusCode: statusCode);
  }

  getBody(Map<String, dynamic>? body, BodyType bodyType) {
    if (bodyType == BodyType.json) {
      return jsonEncode(body);
    } else {
      return FormData.fromMap(body ?? {});
    }
  }
}
