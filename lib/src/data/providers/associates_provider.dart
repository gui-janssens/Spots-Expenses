import 'package:flutter/material.dart';

import '../../locator.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class AssociatesProvider with ChangeNotifier {
  static AssociatesProvider get instance => locator<AssociatesProvider>();

  final AssociatesRepository _associatesRepository = AssociatesRepositoryImpl();

  late List<Associate> associates;
}
