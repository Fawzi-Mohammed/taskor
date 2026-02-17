import 'dart:convert';
import 'dart:io';

import 'package:taskor/core/services/remote/api_response.dart';

class DioClient {
  DioClient({required String baseUrl, HttpClient? httpClient})
    : _baseUrl = baseUrl,
      _httpClient = httpClient ?? HttpClient();

  final String _baseUrl;
  final HttpClient _httpClient;

  Future<ApiResponse<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final request = await _httpClient.postUrl(_buildUri(path));
    _setHeaders(request, headers);

    if (body != null && body.isNotEmpty) {
      request.write(jsonEncode(body));
    }

    final response = await request.close();
    return _toApiResponse(response);
  }

  Uri _buildUri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$_baseUrl$normalizedPath');
  }

  void _setHeaders(HttpClientRequest request, Map<String, String>? headers) {
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.acceptHeader, 'application/json');
    headers?.forEach(request.headers.set);
  }

  Future<ApiResponse<Map<String, dynamic>>> _toApiResponse(
    HttpClientResponse response,
  ) async {
    final rawBody = await utf8.decoder.bind(response).join();
    final decodedBody = _decodeBody(rawBody);

    return ApiResponse<Map<String, dynamic>>(
      statusCode: response.statusCode,
      data: decodedBody,
      message: _extractMessage(decodedBody),
    );
  }

  Map<String, dynamic> _decodeBody(String rawBody) {
    if (rawBody.trim().isEmpty) {
      return <String, dynamic>{};
    }

    try {
      final decoded = jsonDecode(rawBody);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return <String, dynamic>{'data': decoded};
    } catch (_) {
      return <String, dynamic>{
        'message': _extractHtmlError(rawBody) ?? rawBody,
      };
    }
  }

  String? _extractMessage(Map<String, dynamic> body) {
    final candidates = <Object?>[
      body['message'],
      body['error'],
      body['msg'],
      body['detail'],
    ];

    for (final candidate in candidates) {
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate;
      }
    }

    return null;
  }

  String? _extractHtmlError(String rawBody) {
    final preTag = RegExp(
      r'<pre>(.*?)</pre>',
      dotAll: true,
      caseSensitive: false,
    ).firstMatch(rawBody);
    final htmlError = preTag?.group(1)?.trim();
    if (htmlError != null && htmlError.isNotEmpty) {
      return htmlError;
    }

    return null;
  }
}
