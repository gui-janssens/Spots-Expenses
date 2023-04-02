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
        Row(
          children: [
            SizedBox(width: 7.5),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              documentNumber,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 7.5),
          ],
        ),
      ],
    );
  }
}
