import 'package:crypto_bepay/features/wallet/presentation/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../providers/send_flow_notifier.dart';
import '../providers/wallet_provider.dart';


class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(title: Text('My Wallet')),
      body: walletState.when(
        data: (tokens) {
          return ListView.builder(
            itemCount: tokens.length,
            itemBuilder: (_, index) {
              final token = tokens[index];
              return TokenCard(
                token: token,
                onSend: () {
                  ref.read(sendFlowProvider.notifier).selectToken(token);
                 context.push(AppRoutes.recipient);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
