import 'package:flutter/material.dart';
import 'package:spots_expenses/src/interface/views/company/widgets/expenses.dart';
import 'package:spots_expenses/src/interface/widgets/entity_header.dart';
import 'package:stacked/stacked.dart';

import 'company_view_model.dart';

class CompanyView extends StatelessWidget {
  static const route = '/company';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompanyViewModel>.reactive(
      viewModelBuilder: () => CompanyViewModel(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              EntityHeader(
                title: viewModel.companyProvider.company.name,
                documentNumber:
                    'CNPJ: ${viewModel.companyProvider.company.cnpj}',
              ),
              SizedBox(height: 25),
              Expenses()
            ],
          ),
        ),
      ),
    );
  }
}
