import 'package:flutter/material.dart';

class SettingsSticker extends StatelessWidget {
  final Widget? header;
  final Widget? headerDivider;
  final Widget? content;
  final EdgeInsetsGeometry contentPadding = EdgeInsetsGeometry.only(top: 12.0);

  SettingsSticker({
    super.key,
    this.header,
    this.headerDivider,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(header != null) ...[
          header!
        ],
        if(headerDivider != null) ...[
          headerDivider!
        ],
        if(content != null) ...[
          Padding(
            padding: contentPadding,
            child: content!,
          )
        ]
      ],
    );
  }
}
