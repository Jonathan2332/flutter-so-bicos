import 'package:flutter/material.dart';

class SbNavigationDestination extends NavigationDestination {
  final String route;
  const SbNavigationDestination({
    super.key,
    super.selectedIcon,
    required super.icon,
    required super.label,
    super.tooltip,
    super.enabled,
    required this.route
  });
}
