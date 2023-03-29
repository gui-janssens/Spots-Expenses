import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  static const route = '/';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, child) => const Scaffold(),
    );
  }
}
