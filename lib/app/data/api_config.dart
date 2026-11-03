class ApiConfig {
  static const String baseUrl = 'https://dateapi.spinfotechindia.com';

  static String url(String path) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return '$baseUrl$normalized';
  }
}
