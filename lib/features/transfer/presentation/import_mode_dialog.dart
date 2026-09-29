import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

/// How an imported library should be applied.
enum ImportMode { merge, replace }

/// Asks whether an import should merge into or replace the current library.
Future<ImportMode?> showImportModeDialog(BuildContext context) =>
    showFDialog<ImportMode>(
      context: context,
      builder: (context, style, animation) => FDialog(
        animation: animation,
        builder: (context, style) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Import library',
              style: context.theme.typography.display.xs.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Merge adds the imported entries to your current library. '
              'Replace deletes your current library first.',
              style: context.theme.typography.body.sm,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                FButton(
                  variant: FButtonVariant.outline,
                  onPress: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FButton(
                  variant: FButtonVariant.outline,
                  onPress: () => Navigator.of(context).pop(ImportMode.merge),
                  child: const Text('Merge'),
                ),
                FButton(
                  variant: FButtonVariant.destructive,
                  onPress: () => Navigator.of(context).pop(ImportMode.replace),
                  child: const Text('Replace'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
