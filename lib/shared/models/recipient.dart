import 'package:equatable/equatable.dart';

import '../enums/recipient_type.dart';

class Recipient extends Equatable {
  final String value;
  final RecipientType type;
  final String? displayName;

  const Recipient({
    required this.value,
    required this.type,
    this.displayName,
  });

  @override
  List<Object?> get props => [
    value,
    type,
    displayName,
  ];
}