import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:medialib/core/router/routes.dart';

/// Describes one entry in the application's primary navigation.
class AppDestination {
  const AppDestination({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final IconData icon;
}

/// The primary navigation destinations, in display order.
///
/// The order here must match the order of the branches registered in
/// `app_router.dart`.
const List<AppDestination> appDestinations = [
  AppDestination(
    route: AppRoutes.library,
    label: 'Library',
    icon: FLucideIcons.library,
  ),
  AppDestination(
    route: AppRoutes.search,
    label: 'Search',
    icon: FLucideIcons.search,
  ),
  AppDestination(
    route: AppRoutes.history,
    label: 'History',
    icon: FLucideIcons.history,
  ),
  AppDestination(
    route: AppRoutes.orders,
    label: 'Orders',
    icon: FLucideIcons.listOrdered,
  ),
  AppDestination(
    route: AppRoutes.settings,
    label: 'Settings',
    icon: FLucideIcons.settings,
  ),
];
