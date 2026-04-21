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

    final resolvedMessage = _resolveFriendlyMessage(response);

    if (response.statusCode >= 500) {
      throw ServerException(resolvedMessage, response.statusCode);
    }

    throw AuthException(resolvedMessage, response.statusCode);
  }

  String _resolveFriendlyMessage(ApiResponse<Map<String, dynamic>> response) {
    final body = response.data ?? <String, dynamic>{};

    final validationMessage = _extractValidationMessage(body['errors']);
    if (validationMessage != null) {
      return validationMessage;
    }

    final rawMessage = (response.message ?? _extractBodyMessage(body)).trim();
    if (rawMessage.isEmpty) {
      return 'Something went wrong. Please try again.';
    }

    return _toFriendlyMessage(rawMessage);
  }

  String _extractBodyMessage(Map<String, dynamic> body) {
    const keys = <String>['message', 'error', 'msg', 'detail'];
    for (final key in keys) {
      final value = body[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return '';
  }

  String? _extractValidationMessage(Object? errors) {
    if (errors is! List || errors.isEmpty) {
      return null;
    }

    for (final entry in errors) {
      if (entry is String && entry.trim().isNotEmpty) {
        return _toFriendlyMessage(entry.trim());
      }

      if (entry is Map<String, dynamic>) {
        final message =
            entry['message'] ??
            entry['msg'] ??
            entry['detail'] ??
            entry['path'];
        if (message is String && message.trim().isNotEmpty) {
          return _toFriendlyMessage(message.trim());
        }
      }
    }

    return null;
  }

  String _toFriendlyMessage(String message) {
    final lower = message.toLowerCase();

    if (lower == 'validation error') {
      return 'Please review your information and try again.';
    }

    if (lower.contains('password') && lower.contains('required pattern')) {
      return 'Password must be at least 8 characters and include uppercase, lowercase, and a number.';
    }

    if (lower.contains('incorrect password') ||
        lower.contains('invalid credentials')) {
      return 'Email or password is incorrect. Please use the exact same email used during sign up.';
    }

    if (lower.contains('email') && lower.contains('valid email')) {
      return 'Please enter a valid email address.';
    }

    if (lower.contains('user not found')) {
      return 'User not found.';
    }

    if (lower.contains('code is invalid')) {
      return 'Code is invalid.';
    }

    if (lower.contains('email and newpassword are required')) {
      return 'Email and new password are required.';
    }

    if (lower.contains('not allowed to be empty') ||
        lower.contains('is required')) {
      return 'Please fill in all required fields.';
    }

    if (lower.contains('email') &&
        lower.contains('already') &&
        (lower.contains('exist') ||
            lower.contains('used') ||
            lower.contains('taken'))) {
      return 'This email is already in use. Try logging in instead.';
    }

    if (lower.contains('username') &&
        lower.contains('already') &&
        lower.contains('taken')) {
      return 'This username is already taken. Please choose another one.';
    }

    return message;
  }
}
