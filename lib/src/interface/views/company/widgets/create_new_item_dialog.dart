import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spots_expenses/src/data/providers/providers.dart';
import 'package:spots_expenses/src/data/services/firebase_storage_service.dart';
import 'package:spots_expenses/src/interface/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/models/models.dart';
import '../../../utility/utility.dart';

class CreateNewItemDialog extends StatefulWidget {
  const CreateNewItemDialog({super.key});

  @override
  State<CreateNewItemDialog> createState() => _CreateNewItemDialogState();
}

class _CreateNewItemDialogState extends State<CreateNewItemDialog> {
  String? itemName;
  String? unitPrice;
  String? quantity;
  File? file;
  Uint8List? webImage;
  bool addingItem = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 7.5),
            Text('Item name'),
          ],
        ),
        CustomTextField(
          onChanged: (v) {
            if (v.isEmpty) {
              itemName = null;
            } else {
              itemName = v;
            }
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 7.5),
            Text('Unit price'),
          ],
        ),
        CustomTextField(
          controller: MoneyMaskedTextController(
            leftSymbol: 'R\$',
            decimalSeparator: ',',
            thousandSeparator: '.',
            initialValue: 0,
          ),
          onChanged: (v) {
            final temp = v
                .replaceAll('R\$', '')
                .replaceAll(' ', '')
                .replaceAll('.', '')
                .replaceAll(',', '.');
            if (temp == '0.00') {
              unitPrice = null;
            } else {
              unitPrice = temp;
            }
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 7.5),
            Text('Quantity'),
          ],
        ),
        CustomTextField(
          controller: MaskedTextController(mask: '00'),
          hintText: '0',
          onChanged: (v) {
            if (v.isEmpty) {
              quantity = null;
            } else {
              quantity = v;
            }
          },
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () async {
            var xFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (xFile == null) {
              setState(() {
                file = null;
                webImage = null;
              });
              return;
            }
            webImage = await xFile.readAsBytes();
            file = File(xFile.path);
            setState(() {});
          },
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey),
            ),
            child: file == null && webImage == null
                ? Center(
                    child: Icon(Icons.camera_alt_outlined),
                  )
                : kIsWeb
                    ? Image.memory(webImage!)
                    : Image.file(
                        file!,
                        fit: BoxFit.cover,
                      ),
          ),
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
            onPressed: addingItem
                ? () {}
                : () {
                    if (!validateFields()) return;
                    final item = Item(
                      Uuid().v4(),
                      itemName!,
                      double.parse(unitPrice!),
                      int.parse(quantity!),
                      null,
                      null,
                    );

                    createItem(
                      item,
                      kIsWeb ? webImage : null,
                      kIsWeb ? null : file,
                    );
                  },
            child: addingItem
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    'Add new Item',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }

  bool validateFields() {
    final _interface = InterfaceUtility.instance;
    if (itemName == null) {
      _interface.showErrorToast('Item name is mandatory');
      return false;
    }
    if (unitPrice == null) {
      _interface.showErrorToast('Unit price is mandatory');
      return false;
    }

    if (quantity == null) {
      _interface.showErrorToast('Quantity is mandatory');
      return false;
    }
    if (int.parse(quantity!) == 0) {
      _interface.showErrorToast('Quantity should be greater than 0');
      return false;
    }
    return true;
  }

  setAddingItem(bool v) {
    setState(() {
      addingItem = v;
    });
  }

  void createItem(Item item, Uint8List? webImage, File? file) async {
    setAddingItem(true);
    TaskSnapshot? result;
    if (file != null || webImage != null) {
      result = await FirebaseStorageService.uploadFile(file, webImage, item.id);
    }

    if (result != null) {
      item.photoUrl = await result.ref.getDownloadURL();
      item.photoKey = result.ref.fullPath;
    }

    final response = await CompanyProvider.instance.createItem(item);

    setAddingItem(false);
    if (response.isOk()) {
      InterfaceUtility.instance.goBack();
      return;
    }

    InterfaceUtility.instance.showErrorToast(response.unwrapErr().message);
  }
}
