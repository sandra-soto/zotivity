import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class localStore {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    var path = await _localPath;
    return File("$path/user.txt");
  }

  Future<String> readUser() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeUser(String user) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$user');
  }
}