import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:so_bicos/ui/designsystem/components/navigation_destination.dart';
import 'package:so_bicos/ui/designsystem/components/blur_filter.dart';
import 'package:so_bicos/ui/designsystem/themes/dimens.dart';

class SbNavigationBar extends StatelessWidget {
  final List<SbNavigationDestination> navDestinations;

  final barBorderRadius = const BorderRadius.all(
    Radius.circular(Dimens.appBarBorderRadius),
  );
  final barAlphaBlur = 0.7;

  const SbNavigationBar({super.key, required this.navDestinations});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: barBorderRadius,
          child: BackdropFilter(
            filter: kBlurFilter,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: barBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary.withValues(alpha: barAlphaBlur),
              ),
              child: SizedBox(
                height: 56,
                width: 250,
                child: NavigationBar(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    return states.contains(WidgetState.focused)
                        ? null
                        : Colors.transparent;
                  }),
                  backgroundColor: Colors.transparent,
                  onDestinationSelected: (index) {
                    context.go(navDestinations[index].route);
                  },
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  destinations: navDestinations,
                  selectedIndex: navDestinations.indexWhere(
                    (dest) =>
                        dest.route == GoRouter.of(context).state.uri.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
