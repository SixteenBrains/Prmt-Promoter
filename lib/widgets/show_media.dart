import 'package:flutter/material.dart';
import '/enums/enums.dart';
import '/widgets/display_image.dart';
import 'custom_video_player.dart';

class ShowMedia extends StatelessWidget {
  final String? mediaUrl;
  final MediaType mediaType;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const ShowMedia({
    Key? key,
    required this.mediaUrl,
    required this.mediaType,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return mediaType == MediaType.image
        ? DisplayImage(
            imageUrl: mediaUrl,
            height: height ?? _canvas.height * 0.25,
            width: width ?? double.infinity,
            fit: fit ?? BoxFit.contain,
          )
        : mediaUrl != null
            ? CustomVideoPlayer(
                videoUrl: mediaUrl!,
                height: height,
                width: width,
              )
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                height: height ?? _canvas.height * 0.25,
                width: width ?? double.infinity,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                ),
              );
  }
}
