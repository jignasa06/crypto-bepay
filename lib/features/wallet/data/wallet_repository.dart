import 'dart:async';

import '../../../shared/models/token_balance.dart';

class WalletRepository {
  Future<List<TokenBalance>> getBalances() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return const [
      TokenBalance(
        symbol: 'USDC',
        name: 'USD Coin',
        network: 'Polygon',
        balance: 250.50,
        usdPrice: 1.0,
      ),
      TokenBalance(
        symbol: 'ETH',
        name: 'Ethereum',
        network: 'Ethereum',
        balance: 0.42,
        usdPrice: 2500,
      ),
      TokenBalance(
        symbol: 'SOL',
        name: 'Solana',
        network: 'Solana',
        balance: 3.25,
        usdPrice: 150,
      ),
      TokenBalance(
        symbol: 'USDT',
        name: 'Tether',
        network: 'Tron',
        balance: 120,
        usdPrice: 1.0,
      ),
    ];
  }
}