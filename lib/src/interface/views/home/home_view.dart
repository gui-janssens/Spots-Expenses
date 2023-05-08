import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data/providers/providers.dart';
import '../views.dart';
import 'home_view_model.dart';
import 'widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: CustomAppBar(viewModel),
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: [
              CompanyView(),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(AssociatesProvider.instance.associates[0].name),
                ),
              ),
              Center(
                child: Text(AssociatesProvider.instance.associates[1].name),
              ),
              Center(
                child: Text(AssociatesProvider.instance.associates[2].name),
              ),
              Center(
                child: Text(AssociatesProvider.instance.associates[3].name),
              ),
            ],
          )),
    );
  }
}
