import 'package:flutter/material.dart';

import '../../../../shared/enums/numeric_keyboard_type.dart';

class NumericKeyboard extends StatelessWidget {
  final NumericKeyboardType keyboardType;
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onBackSpace;

  const NumericKeyboard({
    super.key,
    required this.keyboardType,
    required this.onKeyPressed,
    required this.onBackSpace,
  });

  @override
  Widget build(BuildContext context) {
    final keys = keyboardType == NumericKeyboardType.amount
        ? const [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '.', '0'
    ]
        : const [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '', '0'
    ];

    return SizedBox(
      height: 260,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.55,
        ),
        itemBuilder: (_, index) {
          // Last button -> Backspace
          if (index == 11) {
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onBackSpace,
              child: const Center(
                child: Icon(
                  Icons.backspace_outlined,
                  size: 28,
                ),
              ),
            );
          }

          // Empty space for PIN keyboard
          if (keys[index].isEmpty) {
            return const SizedBox.shrink();
          }

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onKeyPressed(keys[index]),
            child: Center(
              child: Text(
                keys[index],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}