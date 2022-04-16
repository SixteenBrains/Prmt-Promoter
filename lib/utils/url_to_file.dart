import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '/models/failure.dart';

class UrlToFile {
  static Future<File?> convetUrlToFile({required String url}) async {
    try {
      Uint8List? reqFile;
      final http.Response responseData = await http.get(Uri.parse(url));
      reqFile = responseData.bodyBytes;
      var buffer = reqFile.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/img').writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    } catch (error) {
      print('Error in converting url to file  ${error.toString()}');
      throw const Failure(message: 'Error in converting url to file ');
    }
  }
}
