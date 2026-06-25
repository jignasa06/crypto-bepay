import 'package:equatable/equatable.dart';

class TokenBalance extends Equatable {
  final String symbol;
  final String name;
  final String network;
  final double balance;
  final double usdPrice;

  const TokenBalance({
    required this.symbol,
    required this.name,
    required this.network,
    required this.balance,
    required this.usdPrice,
  });

  @override
  List<Object> get props => [
    symbol,
    name,
    network,
    balance,
    usdPrice,
  ];
}