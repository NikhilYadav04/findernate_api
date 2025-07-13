class ApiConfig {
  //* Base URLs for different environments
  static const String _baseUrlDev = 'https://dev-api.example.com';
  static const String _baseUrlStaging = 'https://staging-api.example.com';
  static const String _baseUrlProd = 'https://api.example.com';

  //* Current environment
  static const String currentEnvironment = 'dev';

  static String get baseUrl {
    switch (currentEnvironment) {
      case 'dev':
        return _baseUrlDev;
      case 'staging':
        return _baseUrlStaging;
      case 'prod':
        return _baseUrlProd;
      default:
        return _baseUrlDev;
    }
  }

  //* API Configuration
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const int sendTimeout = 10000;
}
