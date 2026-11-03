// ponytail: hardcoded USD; switch to intl NumberFormat.currency if locales matter.
String formatPrice(int cents) => '\R${(cents / 100).toStringAsFixed(2)}';
