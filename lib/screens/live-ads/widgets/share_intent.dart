import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/services/social_share_service.dart';
import '/widgets/show_snackbar.dart';
import 'package:uuid/uuid.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/promoted_ad.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/live-ads/cubit/ads_cubit.dart';
import '/enums/enums.dart';
import '/models/ad.dart';
import '/screens/live-ads/widgets/social_share_btn.dart';

import 'label_icon.dart';
import 'metrics_widget.dart';

class ShareIntent extends StatelessWidget {
  final Ad? ad;

  const ShareIntent({Key? key, required this.ad}) : super(key: key);

  void share(BuildContext context, {required SharePlatform platform}) async {
    final authorId = context.read<AuthBloc>().state.promoter?.promoterId;
    final shareId = const Uuid().v4();

    // final query = jsonEncode({
    //   // ignore: prefer_single_quotes
    //   'promoterId': authorId,
    //   'adId': '${ad?.adId}',
    //   'adUrl': '${ad?.targetLink}'
    //   // we also add the platform where the ad got shared
    // });

    // final query = {
    //   // ignore: prefer_single_quotes
    //   'promoterId': authorId,
    //   'adId': '${ad?.adId}',
    //   'adUrl': '${ad?.targetLink}'
    //   // we also add the platform where the ad got shared
    // };
    final affliateUrl =
        'https://us-central1-prmt-business.cloudfunctions.net/promote?shareId=$shareId&adId=${ad?.adId}&promoterId=$authorId&adUrl=${ad?.targetLink}';
    // 'https://us-central1-prmt-business.cloudfunctions.net/promote?data=$query';

    // print('Query ${query.toString()}');

    final promotedAd = PromotedAd(
      ad: ad,
      affiliateUrl: affliateUrl,
      clickCount: 0,
      conversion: 0,
      authorId: authorId,
      clicks: const [],
    );

    FileType fileType;

    switch (ad?.adType) {
      case MediaType.image:
        fileType = FileType.image;

        break;

      case MediaType.video:
        fileType = FileType.video;

        break;

      default:
        fileType = FileType.image;
    }
    if (platform == SharePlatform.instagram) {
      Clipboard.setData(
          ClipboardData(text: 'Check out\n${ad?.title}\n$affliateUrl'));
    }

    final String? result = await SocialShareService.socialShare(
      platform,
      storyUrl: ad?.mediaUrl,
      text: 'Check out\n${ad?.title}\n$affliateUrl',
      mediaType: fileType,
    );

    print('Result of share $share');

    // final result = await ShareService.shareMedia(
    //       storyUrl: ad?.mediaUrl,
    //       text: affliateUrl,
    //       mediaType: ad?.adType ?? MediaType.none,
    //     ) ??
    //     false;

    print('Result of share $result');
    if (result == 'succuss') {
      print('Shared ad');
      if (authorId != null) {
        print('this runs 1');
        context
            .read<AdsCubit>()
            .promoteAd(promotedAd: promotedAd, shareId: shareId);
      }
    } else {
      ShowSnackBar.showSnackBar(context,
          title: result, backgroundColor: Colors.orangeAccent);
    }
    Navigator.of(context).pushNamed(DashBoard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return Container(
      //   height: 900,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'This is a promotion by ${ad?.author?.businessName} of ${ad?.author?.city}, ${ad?.author?.state}. You can earn the following:',
                //'This is a promotion by Bharat Traders Pvt. Ltd. of Mumbai, MH. You can earn the following:',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
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
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F6F6),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  LabelIcon(
                                    label: '172',
                                    icon: Icons.done,
                                  ),
                                  LabelIcon(
                                      label: '33', icon: Icons.shopping_cart),
                                  LabelIcon(
                                    label: '12:45 hrs',
                                    icon: Icons.lock_clock_outlined,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SocialShareBtn(
                bgColor: const Color(0xff37B44F),
                icon: FontAwesomeIcons.whatsappSquare,
                label: 'SHARE IN WHATSAPP',
                //onTap: showShareIntent,
                onTap: () async =>
                    share(context, platform: SharePlatform.whatsapp),
              ),
              SocialShareBtn(
                bgColor: const Color(0xff2588E7),
                icon: FontAwesomeIcons.facebookSquare,
                label: 'SHARE IN FACEBOOK',
                onTap: () async =>
                    share(context, platform: SharePlatform.facebook),
                // onTap: () async {
                //   ShareService.shareMedia(
                //     storyUrl: ad?.mediaUrl,
                //     text: '${ad?.title}\n${ad?.targetLink}',
                //     mediaType: ad?.adType ?? MediaType.none,
                //   );
                // final result = await Share.shareFilesWithResult(
                //   [_file!.path],
                //   text: 'Whats app share',
                //   subject: 'Share haa',
                //   // sharePositionOrigin:
                //   //     box!.localToGlobal(Offset.zero) & box.size,
                // );

                // print('Result -${result.status}');
                //Share.shareFiles([_file!.path], text: 'Great picture');
                // Share.share(
                //     'check out my website https://pub.dev/packages/social_share',
                //     subject: 'Look what I made!');
                // SocialShare.shareFacebookStory(_file!.path, '#ffffff',
                //     '#000000', 'https://pub.dev/packages/social_share',
                //     appId: '514746270182591');
                // },
              ),
              SocialShareBtn(
                bgColor: const Color(0xffD3698E),
                icon: FontAwesomeIcons.instagram,
                label: 'SHARE IN INSTAGRAM',
                onTap: () async {
                  share(context, platform: SharePlatform.instagram);

                  // FlutterSocialContentShare.share(
                  //     type: ShareType.instagramWithImageUrl,
                  //     quote: 'This is ad text',
                  //     imageName: 'THhis is image name',
                  //     url:
                  //         'https://pub.dev/packages/flutter_social_content_share',
                  //     imageUrl:
                  //         "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
                },
                //  =>
                //     share(context, platform: SharePlatform.instagram),
              )
              // GestureDetector(
              //   onTap: () {
              //     //   SocialShare.shareOptions('Hello world', imagePath: _file!.path);
              //     //SocialShare.shareWhatsapp(content)
              //   },
              //   child: Image.asset('assets/images/whatsapp-btn.png'),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     //  SocialShare.shareFacebookStory(imagePath, backgroundTopColor, backgroundBottomColor, attributionURL)
              //     //  SocialShare.shareInstagramStory(imagePath)
              //   },
              //   child: Image.asset('assets/images/insta-btn.png'),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Image.asset('assets/images/fb-btn.png'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
