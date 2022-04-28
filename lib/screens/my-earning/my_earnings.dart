import 'package:flutter/material.dart';

class MyEarnings extends StatelessWidget {
  const MyEarnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('My Earnings'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/bg_blue.png',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200.0,
              ),
              const Text('₹ 3,031')
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: const Color(0x2588E71A),
                child: Column(
                  children: const [],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
