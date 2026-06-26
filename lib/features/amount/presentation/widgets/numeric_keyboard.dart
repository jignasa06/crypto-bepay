import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onBackSpace;

  const NumericKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onBackSpace,
  });

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0'];
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
          if (index == 11) {
            return IconButton(
              onPressed: onBackSpace,
              icon: const Icon(Icons.backspace_outlined),
            );
          }
          return InkWell(
            onTap: () => onKeyPressed(keys[index]),
            child: Center(
              child: Text(
                keys[index],
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
