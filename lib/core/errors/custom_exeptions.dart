class CustomExeptions implements Exception {
  final String message;

  CustomExeptions({required this.message});

  @override
  String toString() {
    return message;
  }
}
