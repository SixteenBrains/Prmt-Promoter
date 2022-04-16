import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:video_thumbnail/video_thumbnail.dart';

import 'loading_indicator.dart';

class AdVideoThumbnail extends StatefulWidget {
  final File videoFile;
  const AdVideoThumbnail({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<AdVideoThumbnail> createState() => _AdVideoThumbnailState();
}

class _AdVideoThumbnailState extends State<AdVideoThumbnail> {
  @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  bool _loading = true;

  Uint8List? _image;

  void generateThumbnail() async {
    setState(() {
      _image = null;
    });
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.videoFile.path,
      imageFormat: ImageFormat.PNG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    print('Thumbnail  ------ $uint8list');
    setState(() {
      _image = uint8list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading || _image == null
        ? const Center(
            child: LoadingIndicator(),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.memory(
              _image!,
              fit: BoxFit.contain,
            ),
          );
  }
}
