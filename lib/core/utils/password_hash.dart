import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Minimal local-demo password hashing.
///
/// This app has no real backend to authenticate against yet (PRD §6.2 says
/// auth should ultimately be JWT-based against a server, with a mandatory
/// first online login). Until that exists, credentials only ever get
/// checked against the locally-seeded demo `pengguna` rows, so a salted
/// hash is out of scope — this exists solely so demo passwords are not
/// stored as plain text in the local database.
abstract final class PasswordHash {
  static String hash(String plainText) =>
      sha256.convert(utf8.encode('sakuku::$plainText')).toString();

  static bool verify(String plainText, String hash) =>
      PasswordHash.hash(plainText) == hash;
}
