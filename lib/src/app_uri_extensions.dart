extension UriExtensions on Uri {
  String get extractBaseUrl {
    String baseUrl = '$scheme://$host';
    if (hasPort) {
      baseUrl += ':$port';
    }
    return baseUrl;
  }


}
