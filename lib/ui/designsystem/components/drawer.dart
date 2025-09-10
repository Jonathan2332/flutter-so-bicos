import 'package:flutter/material.dart';

class SbDrawer extends StatelessWidget {
  final Widget? child;
  const SbDrawer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ), //Android 15
            child: child,
          );
        },
      ),
    );
  }
}
