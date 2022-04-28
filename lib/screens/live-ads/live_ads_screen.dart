import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/dashboard/dashboard.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/ads/ads_repository.dart';
import '/screens/live-ads/cubit/ads_cubit.dart';
import 'widgets/label_icon.dart';
import 'widgets/share_intent.dart';
import 'widgets/show_ad_media.dart';

class LiveAdsScreenArgs {
  final bool showSkip;

  LiveAdsScreenArgs({required this.showSkip});
}

class LiveAdsScreen extends StatelessWidget {
  final bool showSkip;
  static const String routeName = '/liveAds';
  const LiveAdsScreen({Key? key, this.showSkip = false}) : super(key: key);

  static Route route({required LiveAdsScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => AdsCubit(
          adsRepository: context.read<AdsRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..fetchLiveAds(),
        child: LiveAdsScreen(
          showSkip: args.showSkip,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: showSkip
          ? TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(DashBoard.routeName),
              child: const Text('Skip Now'),
            )
          : null,
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Live Ads',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<AdsCubit, AdsState>(
        listener: (context, state) {
          print('status of ${state.status} ');
          if (state.status == AdsStatus.adShared) {
            Navigator.of(context).pushNamed(LiveAdsScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state.status == AdsStatus.loading) {
            return const LoadingIndicator();
          }
          print('status of ${state.status} ');
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.liveAds.length,
                    itemBuilder: (context, index) {
                      final ad = state.liveAds[index];
                      print('Ad media -- ${ad?.mediaUrl}');
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: ShowAdMedia(
                                mediaType: ad?.adType,
                                mediaUrl: ad?.mediaUrl,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            title: Text(
                              ad?.title ?? 'N/A',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
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
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) => AdsCubit(
                                        adsRepository:
                                            context.read<AdsRepository>(),
                                        authBloc: context.read<AuthBloc>(),
                                      ),
                                      child: ShareIntent(ad: ad),
                                    );
                                  },
                                );
                              },

                              //  => Navigator.of(context).pushNamed(
                              //     ShareAdScreen.routeName,
                              //     arguments: ShareAdsArgs(ad: ad)),
                              child: const CircleAvatar(
                                radius: 22.0,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  FontAwesomeIcons.bullhorn,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
