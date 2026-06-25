import 'package:equatable/equatable.dart';

class FeeEstimate extends Equatable {
  final double fee;
  final String token;

  const FeeEstimate({
    required this.fee,
    required this.token,
  });

  @override
  List<Object> get props => [
    fee,
    token,
  ];
}