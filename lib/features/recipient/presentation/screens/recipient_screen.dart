import 'package:crypto_bepay/core/router/app_router.dart';
import 'package:crypto_bepay/providers/send_flow_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/validators/recipient_validator.dart';
import 'providers/recipient_provider.dart';
import '../../../../shared/enums/recipient_type.dart';
import '../../../../shared/models/recipient.dart';
import '../widgets/recipient_tile.dart';

class RecipientScreen extends ConsumerStatefulWidget {
  const RecipientScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipientScreenState();
}

class _RecipientScreenState extends ConsumerState<RecipientScreen> {
  late final TextEditingController _recipientController;

  @override
  void initState() {
    super.initState();
    _recipientController = TextEditingController();
  }

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
  }

  void _continue() {
    final error = RecipientValidator.validate(_recipientController.text);
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    final recipient = Recipient(
      value: _recipientController.text.trim(),
      type: RecipientType.bepayId,
    );

    ref.read(sendFlowProvider.notifier).setRecipient(recipient);
    context.push(AppRoutes.amount);
  }

  @override
  Widget build(BuildContext context) {
    final recentRecipients = ref.watch(recentRecipientsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Recipient')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient',
                hintText: 'Enter email, phone or BePay ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Recipients',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 12),
            Expanded(
              child: recentRecipients.when(
                data: (recipients) {
                  return ListView.separated(
                    itemCount: recipients.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final recipient = recipients[index];

                      return RecipientTile(
                        recipient: recipient,
                        onTap: () {
                          _recipientController.text = recipient.value;
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton(
                onPressed: _continue,
                child: const Text("Continue"),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
