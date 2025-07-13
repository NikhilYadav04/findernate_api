import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class Encrypter {
  /// Derives a 256‑bit (32‑byte) key from [password] + [salt]
  static Future<Uint8List> deriveKey({
    required String password,
    required String salt,
    int iterations = 10000,
    int keyLength = 32,
  }) async {
    // 1. Create the PBKDF2 algorithm instance
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: keyLength * 8,
    );

    // 2. Derive a SecretKey from the password + salt
    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: utf8.encode(salt), // the “salt” for PBKDF2
    );

    // 3. Extract the raw bytes
    final keyBytes = await secretKey.extractBytes();
    return Uint8List.fromList(keyBytes);
  }
}
