import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiUnreachableException implements Exception {
  final Object cause;
  ApiUnreachableException(this.cause);
  @override
  String toString() => 'ApiUnreachableException: $cause';
}

class ApiRequestException implements Exception {
  final int statusCode;
  final String message;
  ApiRequestException(this.statusCode, this.message);
  @override
  String toString() => 'ApiRequestException($statusCode): $message';
}

class LoginResult {
  final String token;
  final Map<String, dynamic> pengguna;
  final Map<String, dynamic>? anggota;

  LoginResult({required this.token, required this.pengguna, this.anggota});
}

/// Thin HTTP client for the self-hosted Rimba API (`api/`). Every method
/// throws [ApiUnreachableException] on network failure/timeout — callers
/// (mainly [AuthController] and [SyncService]) treat that as "we're
/// offline" and fall back to local-only behavior, per the offline-first
/// principle in PRD §6.1.
class ApiClient {
  ApiClient({http.Client? client, Duration? timeout})
      : _client = client ?? http.Client(),
        _timeout = timeout ?? const Duration(seconds: 8);

  final http.Client _client;
  final Duration _timeout;

  Uri _uri(String path) => Uri.parse('${ApiConfig.baseUrl}$path');

  Map<String, String> _headers([String? token]) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<http.Response> _send(Future<http.Response> Function() call) async {
    try {
      return await call().timeout(_timeout);
    } catch (e) {
      throw ApiUnreachableException(e);
    }
  }

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    final body = response.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 400) {
      throw ApiRequestException(
        response.statusCode,
        body['error'] as String? ?? 'Request failed (${response.statusCode})',
      );
    }
    return body;
  }

  Future<LoginResult> login(String email, String password) async {
    final response = await _send(
      () => _client.post(
        _uri('/api/auth/login'),
        headers: _headers(),
        body: jsonEncode({'email': email, 'password': password}),
      ),
    );
    final body = _decodeOrThrow(response);
    return LoginResult(
      token: body['token'] as String,
      pengguna: body['pengguna'] as Map<String, dynamic>,
      anggota: body['anggota'] as Map<String, dynamic>?,
    );
  }

  Future<Map<String, dynamic>> syncPush({
    required String token,
    required String deviceId,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await _send(
      () => _client.post(
        _uri('/api/sync/push'),
        headers: _headers(token),
        body: jsonEncode({'deviceId': deviceId, 'items': items}),
      ),
    );
    return _decodeOrThrow(response);
  }

  Future<Map<String, dynamic>> syncPull({
    required String token,
    required DateTime since,
  }) async {
    final response = await _send(
      () => _client.get(
        _uri('/api/sync/pull?since=${Uri.encodeComponent(since.toUtc().toIso8601String())}'),
        headers: _headers(token),
      ),
    );
    return _decodeOrThrow(response);
  }

  Future<Map<String, dynamic>> materiBundle(String token) async {
    final response = await _send(
      () => _client.get(_uri('/api/materi/bundle'), headers: _headers(token)),
    );
    return _decodeOrThrow(response);
  }
}
