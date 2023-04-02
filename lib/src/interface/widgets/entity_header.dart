import 'package:flutter/material.dart';

class EntityHeader extends StatelessWidget {
  final String title;
  final String documentNumber;

  const EntityHeader({
    required this.title,
    required this.documentNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(documentNumber),
      ],
    );
  }
}
