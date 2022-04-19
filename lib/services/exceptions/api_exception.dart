
///Api errors custom exception
class ApiException implements Exception {
  final String error;

  ApiException(this.error);

  @override
  String toString() {
    return error;
  }
}
