/// Column definition for MPDataTable
class MPDataColumn {
  /// Column header label
  final String label;

  /// Column width (optional)
  final double? width;

  /// Whether column is numeric (right-aligned)
  final bool numeric;

  /// Sort callback (optional)
  final int Function(int, bool)? onSort;

  const MPDataColumn({
    required this.label,
    this.width,
    this.numeric = false,
    this.onSort,
  });
}
