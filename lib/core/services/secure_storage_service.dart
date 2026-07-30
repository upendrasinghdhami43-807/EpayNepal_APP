import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provides a wrapper around [FlutterSecureStorage] for secure, local, offline-only key-value storage.
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Writes a secure [value] for the given [key].
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a secure value by its [key], returns null if not found.
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Deletes the securely stored value for the given [key].
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Clears all securely stored values. Use with caution!
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
