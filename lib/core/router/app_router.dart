import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/amount/presentation/screens/amount_screen.dart';
import '../../features/pin/presentation/screens/pin_screen.dart';
import '../../features/recipient/presentation/screens/recipient_screen.dart';
import '../../features/review/presentation/screens/review_screen.dart';
import '../../features/wallet/presentation/screens/wallet_screen.dart';

class AppRoutes {
  static const wallet = '/';
  static const recipient = '/recipient';
  static const amount = '/amount';
  static const review = '/review';
  static const pin = '/pin';
  static const success = '/success';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.wallet,
  routes: [
    GoRoute(
      path: AppRoutes.wallet,
      builder: (_, __) => const WalletScreen(),
    ),
    GoRoute(
      path: AppRoutes.recipient,
      builder: (_, __) => RecipientScreen(),
    ),
    GoRoute(
      path: AppRoutes.amount,
      builder: (_, __) => const AmountScreen(),
    ),
    GoRoute(
      path: AppRoutes.review,
      builder: (_, __) => const ReviewScreen(),
    ),
    GoRoute(
      path: AppRoutes.pin,
      builder: (_, __) => const PinScreen(),
    ),
  ],
);