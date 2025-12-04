import 'package:flutter/material.dart';

import 'payments.dart';
import 'promo_codes.dart';
import 'promotions.dart';
import 'subscriptions.dart';
import 'stats_commercial.dart';

class DashboardCommercialPage extends StatefulWidget {
  const DashboardCommercialPage({super.key});

  @override
  State<DashboardCommercialPage> createState() => _DashboardCommercialPageState();
}

class _DashboardCommercialPageState extends State<DashboardCommercialPage> {
  int index = 0;

  final pages = const [
    PaymentsPage(),
    PromoCodesPage(),
    PromotionsPage(),
    SubscriptionsPage(),
    StatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discount),
            label: 'Promo Codes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
