import 'dart:async';

import '../../../shared/enums/recipient_type.dart';
import '../../../shared/models/recipient.dart';

class RecipientRepository {
  Future<List<Recipient>> getRecentRecipients() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      Recipient(
        value: 'nikhil@bepay',
        type: RecipientType.bepayId,
        displayName: 'Nikhil',
      ),
      Recipient(
        value: 'raj@gmail.com',
        type: RecipientType.email,
        displayName: 'Raj',
      ),
      Recipient(
        value: '+919999999999',
        type: RecipientType.phone,
        displayName: 'Amit',
      ),
    ];
  }
}