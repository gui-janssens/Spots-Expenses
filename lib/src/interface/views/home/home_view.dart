import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../../data/providers/providers.dart';
import '../../utility/utility.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            actions: [
              Hero(
                tag: '1',
                child: Image.asset(
                  'assets/images/spots_white.png',
                  width: SizerUtil.width / 5,
                ),
              ),
            ],
          ),
          body: Center(child: Text(CompanyProvider.instance.company.name))),
    );
  }
}
