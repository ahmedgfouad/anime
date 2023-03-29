import 'package:anime/api_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
  );
  Future<Response> getData(String path,{Map<String,dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path,queryParameters: queryParams);
      return response;
    } on DioError catch (error) {
      throw _handleError(error);
    } catch (e) {
      rethrow;
    }
  }
}

Exception _handleError(DioError error){
  String errorMessage='';
  switch (error.type){
    case DioErrorType.connectionTimeout:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
      errorMessage ='TimeOut';
      break;
    case DioErrorType.badResponse:
      errorMessage ="Bad Response ${error.response?.statusCode} ${error.response?.statusMessage}";
      break;
      default:
        errorMessage="Network Error";
  }
  return Exception(errorMessage);
}

















