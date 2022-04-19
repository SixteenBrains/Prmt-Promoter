import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/live-ads/widgets/label_icon.dart';
import '/screens/live-ads/widgets/show_ad_media.dart';
import '/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ads/ads_repository.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/widgets/display_image.dart';
import 'widgets/sort_ad.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashBoard({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => DashboardBloc(
          adsRepository: context.read<AdsRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..add(LoadUserPromotedAds()),
        child: const DashBoard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //   final _canvas = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == DashBoardStatus.loading) {
              return const LoadingIndicator();
            }
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 320.0,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/bg_blue.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 500.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(ProfileScreen.routeName),
                                        child: const CircleAvatar(
                                          radius: 22.0,
                                          child: ClipOval(
                                            child: DisplayImage(
                                              imageUrl: null,
                                              height: double.infinity,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'PRMT',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(text: ' - Business'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Stack(
                                      children: const [
                                        Center(
                                          child: Icon(
                                            Icons.notifications_outlined,
                                            size: 25.0,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.0,
                                          right: 10.0,
                                          child: CircleAvatar(
                                            radius: 4.0,
                                            backgroundColor: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        '₹ 2000',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Available earning',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Withdraw Money',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Number of clicks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Total Conversion',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    '3,763',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '40',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ads promoted by me',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SortAds(onChanged: () {
                          //context.read<AdsCubit>().toogleRecent();
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.promotedAds.length,
                          itemBuilder: (context, index) {
                            final ad = state.promotedAds[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                //vertical: 5.0,
                              ),
                              child: Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
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
                                              label: '33',
                                              icon: Icons.shopping_cart),
                                          LabelIcon(
                                            label: '12:45 hrs',
                                            icon: Icons.lock_clock_outlined,
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        // showModalBottomSheet<void>(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return BlocProvider(
                                        //       create: (context) => AdsCubit(
                                        //         adsRepository:
                                        //             context.read<AdsRepository>(),
                                        //         authBloc: context.read<AuthBloc>(),
                                        //       ),
                                        //       child: ShareIntent(ad: ad),
                                        //     );
                                        //   },
                                        // );
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
                              ),
                            );
                          }))
                ],
              ),
            );
          },
        ));
  }
}
