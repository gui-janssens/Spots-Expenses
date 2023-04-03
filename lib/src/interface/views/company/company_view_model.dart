import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/models.dart';
import '../../../data/providers/providers.dart';
import '../../../data/services/firebase_storage_service.dart';
import '../../utility/utility.dart';
import 'widgets/create_new_item_dialog.dart';

class CompanyViewModel extends BaseViewModel {
  final companyProvider = CompanyProvider.instance;
  final _interface = InterfaceUtility.instance;

  void popCreateNewItemDialog() {
    _interface.showCustomDialog(
      widget: CreateNewItemDialog(
        createItem: (item, webImage, file) {
          createItem(item, webImage, file);
        },
      ),
    );
  }

  void createItem(Item item, Uint8List? webImage, File? file) async {
    TaskSnapshot? result;
    _interface.showLoader();
    if (file != null || webImage != null) {
      result = await FirebaseStorageService.uploadFile(file, webImage, item.id);
    }

    if (result != null) {
      item.photoUrl = await result.ref.getDownloadURL();
      item.photoKey = result.ref.fullPath;
    }

    final response = await companyProvider.createItem(item);
    _interface.closeLoader();

    if (response.isOk()) {
      _interface.goBack();
      return;
    }

    _interface.showErrorToast(response.unwrapErr().message);
  }

  void deleteItem(Item item) async {
    var proceed = false;

    await _interface.showDialogMessage(
      title: 'Attention!',
      message:
          'Are you sure you want to proceed with the deletion of item ${item.name}',
      actions: [
        DialogAction(
          title: 'No, go back!',
          color: Colors.red,
          onPressed: () => _interface.goBack(),
        ),
        DialogAction(
          title: 'Yes, continue.',
          color: AppColors.primary,
          onPressed: () {
            proceed = true;
            _interface.goBack();
          },
        ),
      ],
    );

    if (!proceed) return;

    _interface.showLoader();

    if (item.photoKey != null) {
      await FirebaseStorageService.deleteFile(item.photoKey!);
    }

    final response = await companyProvider.deleteItem(item);
    _interface.closeLoader();

    if (response.isErr()) {
      _interface.showErrorToast(response.unwrapErr().message);
    }
  }
}
