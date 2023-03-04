class BackupException implements Exception {
  String get message =>
      "There was an issue during the data backup process on the server. Please make sure that you are connected to the internet.";

  @override
  String toString() {
    return message;
  }
}
