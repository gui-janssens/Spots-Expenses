import 'package:flutter/material.dart';

import '../../locator.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class CompanyProvider with ChangeNotifier {
  static CompanyProvider get instance => locator<CompanyProvider>();

  final CompanyRepository _companyRepository = CompanyRepositoryImpl();

  late Company company;
}
