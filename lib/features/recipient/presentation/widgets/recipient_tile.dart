import 'package:crypto_bepay/shared/models/recipient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipientTile extends StatelessWidget {
  final Recipient recipient;
  final VoidCallback onTap;

  const RecipientTile({
    super.key,
    required this.recipient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(recipient.displayName ?? recipient.value),
      subtitle: Text(recipient.value),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
