class AmountValidator {
  static String? validate({
    required String amount,
    required double balance,
  }) {
    if (amount.isEmpty ||
        amount == '0' ||
        amount == '0.') {
      return 'Enter amount greater than zero';
    }

    final parsed =
    double.tryParse(amount);

    if (parsed == null) {
      return 'Invalid amount';
    }

    if (parsed > balance) {
      return 'Insufficient balance';
    }

    return null;
  }
}