import 'package:flutter/material.dart';

class RecipientCard extends StatelessWidget {
  final String recipient;

  const RecipientCard({
    super.key,
    required this.recipient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person_outline),
        ),
        title: const Text(
          'Recipient',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(recipient),
      ),
    );
  }
}