import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../../utility/utility.dart';
import '../../../widgets/widgets.dart';

class RefillItemDialog extends StatelessWidget {
  final Function(int, double) onRefill;

  RefillItemDialog({super.key, required this.onRefill});

  final MaskedTextController _quantityController =
      MaskedTextController(mask: '00');
  final MoneyMaskedTextController _unitPriceController =
      MoneyMaskedTextController(
    leftSymbol: 'R\$',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 7.5),
            Text(
              'Unit price',
            ),
          ],
        ),
        CustomTextField(
          controller: _unitPriceController,
          onChanged: (_) {},
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 7.5),
            Text(
              'Quantity to refill',
            ),
          ],
        ),
        CustomTextField(
          controller: _quantityController,
          onChanged: (_) {},
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, 50),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (!validateFields()) return;

              onRefill(
                int.parse(_quantityController.text),
                double.parse(_unitPriceController.text
                    .replaceAll('R\$', '')
                    .replaceAll(' ', '')
                    .replaceAll('.', '')
                    .replaceAll(',', '.')),
              );
            },
            child: Text(
              'Refill item',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  bool validateFields() {
    final unitPrice = double.parse(_unitPriceController.text
        .replaceAll('R\$', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '.'));

    if (unitPrice == 0) {
      InterfaceUtility.instance
          .showErrorToast('Unit price should be greater than 0.');
      return false;
    }

    if (_quantityController.text.isEmpty) {
      InterfaceUtility.instance.showErrorToast('Quantity is mandatory.');
      return false;
    }
    if (_quantityController.text == '0') {
      InterfaceUtility.instance
          .showErrorToast('Quantity should be greater than 0.');
      return false;
    }
    return true;
  }
}
