class ServerException implements Exception {
  final String msg;
  ServerException(this.msg);
}

class CacheException implements Exception {
  final String msg;
  CacheException(this.msg);
}

class NetworkException implements Exception {
  final String msg;
  NetworkException(this.msg);
}