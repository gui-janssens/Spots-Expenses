import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../utility/utility.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  static const route = '/';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) => viewModel.loadData(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Hero(
            tag: '1',
            child: Image.asset(
              'assets/images/spots_white.png',
              width: SizerUtil.width / 3,
            ),
          ),
        ),
      ),
    );
  }
}
