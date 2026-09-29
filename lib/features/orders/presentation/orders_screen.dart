import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:medialib/core/widgets/feature_placeholder.dart';

/// Community-created watching and reading orders.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeaturePlaceholder(
    icon: FLucideIcons.listOrdered,
    title: 'Watching & reading orders',
    message:
        'Follow and create orders for franchises and comic universes that span '
        'multiple works.',
  );
}
