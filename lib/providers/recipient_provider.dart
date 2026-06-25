import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/models/recipient.dart';
import 'repository_providers.dart';

final recentRecipientsProvider =
FutureProvider<List<Recipient>>(
      (ref) {
    return ref
        .read(
      recipientRepositoryProvider,
    )
        .getRecentRecipients();
  },
);