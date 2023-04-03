import 'package:flutter/material.dart';
import 'package:oxidized/oxidized.dart';

import '../../locator.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class CompanyProvider with ChangeNotifier {
  static CompanyProvider get instance => locator<CompanyProvider>();

  final CompanyRepository _companyRepository = CompanyRepositoryImpl();

  late Company company;

  Future<Result<void, AppError>> getCompany() async {
    final response = await _companyRepository.getCompany();

    if (response.isOk()) {
      company = response.unwrap();
      return Result.ok(true);
    }

    return Result.err(response.unwrapErr());
  }

  Future<Result<void, AppError>> createItem(Item item) async {
    final response = await _companyRepository.createItem(company.id, item);

    if (response.isOk()) {
      company.items.add(item);
      notifyListeners();
      return Result.ok(true);
    }

    return Result.err(response.unwrapErr());
  }

  Future<Result<void, AppError>> deleteItem(Item item) async {
    final response = await _companyRepository.deleteItem(company.id, item.id);

    if (response.isOk()) {
      company.items.removeWhere((element) => element.id == item.id);
      notifyListeners();
      return Result.ok(true);
    }

    return Result.err(response.unwrapErr());
  }

  Future<Result<void, AppError>> editItem(Item item) async {
    final response = await _companyRepository.editItem(company.id, item);

    if (response.isOk()) {
      company.items[
          company.items.indexWhere((element) => element.id == item.id)] = item;
      notifyListeners();
      return Result.ok(true);
    }

    return Result.err(response.unwrapErr());
  }
}
