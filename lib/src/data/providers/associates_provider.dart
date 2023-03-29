import 'package:flutter/material.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class AssociatesProvider with ChangeNotifier {
  final AssociatesRepository _associatesRepository = AssociatesRepositoryImpl();

  late List<Associate> associates;
}
