import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:spots_expenses/src/data/models/models.dart';
import 'package:spots_expenses/src/data/providers/providers.dart';

import '../../../utility/utility.dart';
import '../../../widgets/widgets.dart';

class RefillItemDialog extends StatefulWidget {
  final Item item;
  RefillItemDialog(this.item, {super.key});

  @override
  State<RefillItemDialog> createState() => _RefillItemDialogState();
}

class _RefillItemDialogState extends State<RefillItemDialog> {
  final MaskedTextController _quantityController =
      MaskedTextController(mask: '00');

  final MoneyMaskedTextController _unitPriceController =
      MoneyMaskedTextController(
    leftSymbol: 'R\$',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 0,
  );

  bool isRefilling = false;

  setIsRefilling(bool b) {
    isRefilling = b;
    setState(() {});
  }

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

              refillItem(
                widget.item,
                int.parse(_quantityController.text),
                double.parse(_unitPriceController.text
                    .replaceAll('R\$', '')
                    .replaceAll(' ', '')
                    .replaceAll('.', '')
                    .replaceAll(',', '.')),
              );
            },
            child: isRefilling
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    'Refill item',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }

  void refillItem(Item item, int quantity, double unitPrice) async {
    setIsRefilling(true);

    final newAveragePrice =
        (item.averagePrice * item.quantity + quantity * unitPrice) /
            (item.quantity + quantity);

    final newQuantity = item.quantity + quantity;

    var editedItem = Item(
      item.id,
      item.name,
      newAveragePrice,
      newQuantity,
      item.photoUrl,
      item.photoKey,
    );

    final response = await CompanyProvider.instance.editItem(editedItem);

    setIsRefilling(false);

    if (response.isOk()) {
      InterfaceUtility.instance.goBack();
      return;
    }

    InterfaceUtility.instance.showErrorToast(response.unwrapErr().message);
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
