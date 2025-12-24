import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

import 'mp_data_column.dart';

/// A data table with adaptive theming
///
/// Follows theme rules:
/// - Header uses adaptive background
/// - Rows alternate with subtle background differences
/// - Dividers use adaptive divider color
/// - Text uses semantic colors
class MPDataTable extends StatelessWidget {
  /// Column definitions
  final List<MPDataColumn> columns;

  /// Row data (List of Lists, where each inner list is a row)
  final List<List<String>> rows;

  /// Enable sorting
  final bool sortable;

  /// Show checkbox column
  final bool showCheckbox;

  /// Minimum padding for each cell
  final double? dataRowMinHeight;

  /// Minimum padding for each cell
  final double? dataRowMaxHeight;

  /// Heading row height
  final double? headingRowHeight;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Show borders
  final bool showBorders;

  const MPDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortable = false,
    this.showCheckbox = false,
    this.dataRowMinHeight,
    this.dataRowMaxHeight,
    this.headingRowHeight,
    this.borderRadius,
    this.showBorders = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.mp;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: showBorders
            ? Border.all(
                color: theme.borderColor,
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: theme.adaptiveShadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: DataTable(
          columns: columns
              .map(
                (col) => DataColumn(
                  label: Text(
                    col.label,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  numeric: col.numeric,
                  onSort: sortable ? col.onSort : null,
                ),
              )
              .toList(),
          rows: rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;

            return DataRow(
              color: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (index % 2 == 0) {
                    return theme.adaptiveBackgroundColor;
                  }
                  return theme.cardColor;
                },
              ),
              cells: row.map((cell) {
                return DataCell(
                  Text(
                    cell,
                    style: TextStyle(
                      color: theme.textColor,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
          dataRowMinHeight: dataRowMinHeight,
          dataRowMaxHeight: dataRowMaxHeight,
          headingRowHeight: headingRowHeight,
          headingRowColor: WidgetStateProperty.all(
            theme.surfaceColor,
          ),
          horizontalMargin: 12,
          columnSpacing: 16,
          showCheckboxColumn: showCheckbox,
          dividerThickness: 1,
        ),
      ),
    );
  }
}
