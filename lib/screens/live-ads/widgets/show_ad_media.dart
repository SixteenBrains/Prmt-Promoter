import 'dart:typed_data';

import 'package:flutter/material.dart';
import '/enums/enums.dart';
import '/widgets/display_image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ShowAdMedia extends StatefulWidget {
  final String? mediaUrl;
  final MediaType? mediaType;
  final double? height;
  final double? width;

  const ShowAdMedia(
      {Key? key,
      required this.mediaUrl,
      required this.mediaType,
      this.height,
      this.width})
      : super(key: key);

  @override
  State<ShowAdMedia> createState() => _ShowAdMediaState();
}

class _ShowAdMediaState extends State<ShowAdMedia> {
  @override
  void initState() {
    super.initState();
    if (widget.mediaType == MediaType.video) {
      generateThumbnail();
    }
  }

  Uint8List? _videoThumbnail;

  void generateThumbnail() async {
    // setState(() {
    //  // _image = null;
    // });
    if (widget.mediaUrl != null) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: widget.mediaUrl!,
        imageFormat: ImageFormat.PNG,
        maxWidth:
            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );

      /// print('Thumbnail  ------ $uint8list');
      setState(() {
        _videoThumbnail = uint8list;
        // _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return widget.mediaType == MediaType.image
        ? DisplayImage(
            imageUrl: widget.mediaUrl,
            height: widget.height ?? _canvas.height * 0.25,
            width: widget.width ?? double.infinity,
            fit: BoxFit.contain,
          )
        : _videoThumbnail != null
            ? Image.memory(
                _videoThumbnail!,
                height: widget.height ?? _canvas.height * 0.25,
                width: widget.width ?? double.infinity,
                fit: BoxFit.cover,
              )
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                height: widget.height ?? _canvas.height * 0.25,
                width: widget.width ?? double.infinity,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                ),
              );
  }
}
