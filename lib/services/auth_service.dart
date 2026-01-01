import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _adminUsername = 'alshalabi311';
  static const String _adminPassword = 'Shalabi1@';

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  /// Initialize the auth service with SharedPreferences
  Future<void> initialize() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    await _ensureInitialized();
    final token = _prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Get the current auth token
  Future<String?> getToken() async {
    await _ensureInitialized();
    return _prefs.getString(_tokenKey);
  }

  /// Login with username and password
  /// Returns true if credentials are correct, false otherwise
  Future<bool> login(String username, String password) async {
    await _ensureInitialized();

    // Validate credentials
    if (username == _adminUsername && password == _adminPassword) {
      // Generate a unique token
      const uuid = Uuid();
      final token = uuid.v4();

      // Store token in SharedPreferences
      await _prefs.setString(_tokenKey, token);
      return true;
    }

    return false;
  }

  /// Logout and clear the token
  Future<void> logout() async {
    await _ensureInitialized();
    await _prefs.remove(_tokenKey);
  }

  /// Ensure the service is initialized
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  /// Validate token (for internal use)
  Future<bool> validateToken(String token) async {
    await _ensureInitialized();
    final storedToken = _prefs.getString(_tokenKey);
    return storedToken == token && token.isNotEmpty;
  }
}
