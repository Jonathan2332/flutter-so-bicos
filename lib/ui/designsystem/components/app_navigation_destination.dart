import 'package:flutter/material.dart';

class AppNavigationDestination extends NavigationDestination {
  final String route;
  const AppNavigationDestination({
    super.key,
    super.selectedIcon,
    required super.icon,
    required super.label,
    super.tooltip,
    super.enabled,
    required this.route
  });
}
