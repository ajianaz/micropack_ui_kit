#!/bin/bash

# Fix async context usage with mounted check
sed -i.bak 's/_showSnackBar(context,/\\nif (mounted) {_showSnackBar(/' lib/pages/mp_card_page.dart

# Remove all trailing commas (optional for clarity)
sed -i.bak 's/,$/g' lib/pages/mp_card_page.dart

# Fix const constructors
sed -i.bak 's/Icon(/const Icon(/g' lib/pages/mp_card_page.dart
sed -i.bak 's/Text(/const Text(/g' lib/pages/mp_card_page.dart
sed -i.bak 's/SizedBox(/const SizedBox(/g' lib/pages/mp_card_page.dart
sed -i.bak 's/EdgeInsets\.all(/const EdgeInsets\.all(/g' lib/pages/mp_card_page.dart

# Fix unnecessary breaks
sed -i.bak 's/break;$/\/\/ break; removed/' lib/pages/mp_card_page.dart

echo "Fixed mp_card_page.dart"
