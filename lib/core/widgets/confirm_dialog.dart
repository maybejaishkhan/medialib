import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

/// Shows a modal confirmation dialog and returns whether the user confirmed.
///
/// Used before destructive actions such as deleting a library entry.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final confirmed = await showFDialog<bool>(
    context: context,
    builder: (context, style, animation) => FDialog(
      animation: animation,
      builder: (context, style) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: context.theme.typography.display.xs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(message, style: context.theme.typography.body.sm),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 8,
            children: [
              FButton(
                variant: FButtonVariant.outline,
                onPress: () => Navigator.of(context).pop(false),
                child: Text(cancelLabel),
              ),
              FButton(
                variant: destructive
                    ? FButtonVariant.destructive
                    : FButtonVariant.primary,
                onPress: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return confirmed ?? false;
}
