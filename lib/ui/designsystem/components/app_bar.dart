import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:so_bicos/ui/designsystem/components/blur_filter.dart';
import 'package:so_bicos/ui/designsystem/themes/dimens.dart';

class SbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? flexibleSpace;

  @override
  final Size preferredSize;

  final barBorderRadius = const BorderRadius.all(
    Radius.circular(Dimens.appBarBorderRadius),
  );
  final barAlphaBlur = 0.7;

  const SbAppBar({super.key, this.flexibleSpace, required this.preferredSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final SystemUiOverlayStyle systemUiOverlayStyle;
    if(theme.brightness == Brightness.dark)
    {
      systemUiOverlayStyle = SystemUiOverlayStyle.light;
    }
    else
    {
      systemUiOverlayStyle = SystemUiOverlayStyle.dark;
    }
    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(MediaQuery.sizeOf(context).width, 56.0),
        ),
        child: BackdropFilter(
          filter: kBlurFilter,
          child: AppBar(
            systemOverlayStyle: systemUiOverlayStyle.copyWith(
              systemNavigationBarColor: theme.colorScheme.inversePrimary.withValues(alpha: barAlphaBlur),
              systemNavigationBarIconBrightness: theme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
            ),
            backgroundColor: theme.colorScheme.inversePrimary.withValues(
              alpha: barAlphaBlur,
            ),
            leading: Container(),
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.viewPaddingOf(context).top,
              ),
              child: flexibleSpace,
            ),
          ),
        ),
      ),
    );
  }
}
