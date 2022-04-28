import 'package:flutter/material.dart';
import 'package:prmt_promoter/widgets/bottom_nav_button.dart';

class MyEarnings extends StatelessWidget {
  static const String routeName = '/myEarnings';
  const MyEarnings({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyEarnings(),
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
      body: Column(
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
                          '₹ 3,031',
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
                          '₹30, 763',
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
                    const Text(
                      '3,763',
                      style: TextStyle(
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
                    const Text(
                      '39',
                      style: TextStyle(
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
      ),
    );
  }
}
