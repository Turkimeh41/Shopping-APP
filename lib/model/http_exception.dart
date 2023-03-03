class HTTPException implements Exception {
  final String error;
  HTTPException(this.error);

  @override
  String toString() {
    return error;
  }
}
