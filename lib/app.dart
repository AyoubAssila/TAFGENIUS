import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ✅ Correct imports — make sure these EXACT files exist
import 'viewmodels/payments_viewmodel.dart';
import 'viewmodels/promo_codes_viewmodel.dart';
import 'viewmodels/promotions_viewmodel.dart';
import 'viewmodels/subscriptions_viewmodel.dart';
import 'viewmodels/stats_viewmodel.dart';

import 'views/dashboard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentsViewModel()),
        ChangeNotifierProvider(create: (_) => PromoCodesViewModel()),
        ChangeNotifierProvider(create: (_) => PromotionsViewModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionsViewModel()),
        ChangeNotifierProvider(create: (_) => StatsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const DashboardPage(),
      ),
    );
  }
}
