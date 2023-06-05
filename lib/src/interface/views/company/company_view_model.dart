import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/models.dart';
import '../../../data/providers/providers.dart';
import '../../../data/services/firebase_storage_service.dart';
import '../../utility/utility.dart';
import 'widgets/create_new_item_dialog.dart';
import 'widgets/refill_item_dialog.dart';

class CompanyViewModel extends BaseViewModel {
  final companyProvider = CompanyProvider.instance;
  final _interface = InterfaceUtility.instance;

  void popCreateNewItemDialog() {
    _interface.showCustomDialog(
      widget: CreateNewItemDialog(),
    );
  }

  String? deletingItemId;
  setDeletingItemId(String? id) {
    deletingItemId = id;
    notifyListeners();
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

    setDeletingItemId(item.id);
    if (item.photoKey != null) {
      await FirebaseStorageService.deleteFile(item.photoKey!);
    }

    final response = await companyProvider.deleteItem(item);
    setDeletingItemId(null);

    if (response.isErr()) {
      _interface.showErrorToast(response.unwrapErr().message);
    }
  }

  popConsumeItemDialog(Item item) {
    // _interface.showCustomDialog(
    //   widget: ConsumeItemDialog(),
    // );
  }

  popRefillItemDialog(Item item) {
    _interface.showCustomDialog(
      widget: RefillItemDialog(item),
    );
  }
}
