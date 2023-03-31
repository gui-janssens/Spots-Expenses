import 'package:flutter/material.dart';
import 'package:oxidized/oxidized.dart';

import '../../locator.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class AssociatesProvider with ChangeNotifier {
  static AssociatesProvider get instance => locator<AssociatesProvider>();

  final AssociatesRepository _associatesRepository = AssociatesRepositoryImpl();

  late List<Associate> associates;

  Future<Result<void, AppError>> getAssociates() async {
    final response = await _associatesRepository.getAssociates();

    if (response.isOk()) {
      associates = response.unwrap();
      return Result.ok(Null);
    }

    return Result.err(response.unwrapErr());
  }
}
