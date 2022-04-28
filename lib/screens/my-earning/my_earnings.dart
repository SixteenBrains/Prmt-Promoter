import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_promoter/blocs/auth/auth_bloc.dart';
import 'package:prmt_promoter/repositories/ads/ads_repository.dart';
import 'package:prmt_promoter/screens/my-earning/cubit/my_earnings_cubit.dart';
import 'package:prmt_promoter/widgets/loading_indicator.dart';
import '/widgets/bottom_nav_button.dart';

class MyEarnings extends StatelessWidget {
  static const String routeName = '/myEarnings';
  const MyEarnings({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => MyEarningsCubit(
          adsRepository: context.read<AdsRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..loadStats(),
        child: const MyEarnings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: BottomNavButton(
          label: 'WITHDRAW MONEY',
          onTap: () {},
          isEnabled: true,
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'My Earnings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<MyEarningsCubit, MyEarningsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == MyEarningsStatus.loading) {
            return const LoadingIndicator();
          }
          return Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/background_bg.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 140.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Text(
                              '₹ 0',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Available earning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            SizedBox(height: 30.0),
                            Text(
                              '₹ 0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'My all time earnings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 90.0,
                    width: 170.0,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.clickCount ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          'Total Clicks',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 90.0,
                    width: 170.0,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.conversion ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          'Total Conversion',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
