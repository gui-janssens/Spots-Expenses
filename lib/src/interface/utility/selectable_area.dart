import 'package:flutter/material.dart';

class SelectableAreaWrapper extends StatelessWidget {
  final Widget page;
  const SelectableAreaWrapper(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: page,
    );
  }
}
