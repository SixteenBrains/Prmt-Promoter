import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:prmt_promoter/enums/enums.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ShareService {
  static Future<void> shareMedia({
    required String? storyUrl,
    required String? text,
    required MediaType mediaType,
  }) async {
    try {
      String mediaPath;
      // _storyController.pause();
      if (storyUrl != null) {
        final response = await http.get(Uri.parse(storyUrl));

        final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        print('Paths of media ${temp.path}');
        mediaPath = mediaType == MediaType.video
            ? '${temp.path}/video.mp4'
            : '${temp.path}/image.jpg';
        // final imagePath = '${temp.path}/image.jpg';
        //  final imagePath = '${temp.path}/videos.mp4';
        File(mediaPath).writeAsBytesSync(bytes);
        print('Image path --$mediaPath');

        final result =
            await Share.shareFilesWithResult([mediaPath], text: text);
        print('Result --- ${result.status}');

        //await Share.shareFiles([mediaPath], text: text ?? '');
        // _storyController.play();
      }
    } catch (error) {
      print('Error sharing story');
    }
  }
}
