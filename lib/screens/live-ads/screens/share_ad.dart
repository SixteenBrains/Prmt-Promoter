import 'dart:io';

import 'package:flutter/material.dart';
import '/screens/live-ads/widgets/label_icon.dart';
import '/screens/live-ads/widgets/metrics_widget.dart';
import '/utils/url_to_file.dart';
import '/widgets/loading_indicator.dart';
import '/models/ad.dart';
import 'package:social_share/social_share.dart';

class ShareAdsArgs {
  final Ad? ad;

  const ShareAdsArgs({required this.ad});
}

class ShareAdScreen extends StatefulWidget {
  static const String routeName = '/shareAd';
  const ShareAdScreen({Key? key, required this.ad}) : super(key: key);

  final Ad? ad;

  static Route route({required ShareAdsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ShareAdScreen(ad: args.ad),
    );
  }

  @override
  State<ShareAdScreen> createState() => _ShareAdScreenState();
}

class _ShareAdScreenState extends State<ShareAdScreen> {
  File? _file;

  @override
  void initState() {
    super.initState();
    getFile();
  }

  void getFile() async {
    if (widget.ad?.mediaUrl != null) {
      final file = await UrlToFile.convetUrlToFile(url: widget.ad!.mediaUrl!);
      if (file != null) {
        setState(() {
          _file = file;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: _file == null
          ? const LoadingIndicator()
          : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'This is a promotion by Bharat Traders Pvt. Ltd. of Mumbai, MH. You can earn the following:',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF6E0),
                        borderRadius: BorderRadius.circular(17.0),
                        border: Border.all(
                          color: const Color(0xffFEDD87),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              MetricsWidget(
                                width: _canvas.width * 0.458,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                ),
                              ),
                              MetricsWidget(
                                width: _canvas.width * 0.458,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(16.0),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: const Color(0xffF6F6F6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Following numbers of clicks, conversions and deadline time is left on this ad, so hurry!',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      LabelIcon(
                                        label: '172',
                                        icon: Icons.done,
                                      ),
                                      LabelIcon(
                                          label: '33',
                                          icon: Icons.shopping_cart),
                                      LabelIcon(
                                        label: '12:45 hrs',
                                        icon: Icons.lock_clock_outlined,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        SocialShare.shareOptions('Hello world',
                            imagePath: _file!.path);
                        //SocialShare.shareWhatsapp(content)
                      },
                      child: Image.asset('assets/images/whatsapp-btn.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        //  SocialShare.shareFacebookStory(imagePath, backgroundTopColor, backgroundBottomColor, attributionURL)
                        //  SocialShare.shareInstagramStory(imagePath)
                      },
                      child: Image.asset('assets/images/insta-btn.png'),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/fb-btn.png'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
