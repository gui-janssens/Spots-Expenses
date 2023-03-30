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
}
