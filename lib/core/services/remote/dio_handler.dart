import 'dart:io';

import 'package:taskor/core/error/exceptions.dart';
import 'package:taskor/core/services/remote/api_response.dart';
import 'package:taskor/core/services/remote/dio_client.dart';

class DioHandler {
  const DioHandler(this._client);

  final DioClient _client;

  Future<ApiResponse<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.post(path, body: body, headers: headers);
      return _guardResponse(response);
    } on SocketException catch (error) {
      throw OfflineException(error.message);
    }
  }

  ApiResponse<Map<String, dynamic>> _guardResponse(
    ApiResponse<Map<String, dynamic>> response,
  ) {
    if (response.isSuccess) {
      return response;
    }

    if (response.statusCode >= 500) {
      throw ServerException(
        response.message ?? 'Server error',
        response.statusCode,
      );
    }

    throw AuthException(
      response.message ?? 'Request failed',
      response.statusCode,
    );
  }
}
