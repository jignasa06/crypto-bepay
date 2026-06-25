import 'package:flutter/material.dart';

class RecipientScreen extends StatelessWidget {
  const RecipientScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipient',
        ),
      ),
      body: const Center(
        child: Text(
          'Recipient Screen',
        ),
      ),
    );
  }
}