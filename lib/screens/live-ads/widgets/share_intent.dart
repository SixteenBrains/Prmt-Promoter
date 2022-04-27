import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prmt_promoter/blocs/auth/auth_bloc.dart';
import 'package:prmt_promoter/screens/dashboard/dashboard.dart';
import '/screens/live-ads/cubit/ads_cubit.dart';
import '/enums/enums.dart';
import '/models/ad.dart';
import '/services/share_service.dart';
import '/screens/live-ads/widgets/social_share_btn.dart';

import 'label_icon.dart';
import 'metrics_widget.dart';

class ShareIntent extends StatelessWidget {
  final Ad? ad;

  const ShareIntent({Key? key, required this.ad}) : super(key: key);

  void share(BuildContext context) async {
    final result = await ShareService.shareMedia(
          storyUrl: ad?.mediaUrl,
          text: '${ad?.title}\n${ad?.targetLink}',
          mediaType: ad?.adType ?? MediaType.none,
        ) ??
        false;

    print('Result of share $result');
    if (result) {
      final authorId = context.read<AuthBloc>().state.promoter?.promoterId;
      if (authorId != null && ad != null) {
        context.read<AdsCubit>().promoteAd(ad: ad, authorId: authorId);
      }

      // context.read<AdsCubit>().promoteAd(adId: ad?.adId);
      Navigator.of(context).pushNamed(DashBoard.routeName);
    }
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
              const Text(
                'This is a promotion by Bharat Traders Pvt. Ltd. of Mumbai, MH. You can earn the following:',
                style: TextStyle(
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
                onTap: () async => share(context),
              ),
              SocialShareBtn(
                bgColor: const Color(0xff2588E7),
                icon: FontAwesomeIcons.facebookSquare,
                label: 'SHARE IN FACEBOOK',
                onTap: () async => share(context),
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
                onTap: () async => share(context),
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
