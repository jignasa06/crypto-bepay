class RecipientValidator {
  static String? validate(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return 'Recipient is required';
    }

    if (trimmed.length < 3) {
      return 'Recipient is too short';
    }

    return null;
  }
}