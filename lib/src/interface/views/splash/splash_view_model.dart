import 'package:stacked/stacked.dart';

import '../../../data/providers/providers.dart';
import '../../utility/utility.dart';
import '../views.dart';

class SplashViewModel extends BaseViewModel {
  final _companyProvider = CompanyProvider.instance;
  final _associatesProvider = AssociatesProvider.instance;
  final _interface = InterfaceUtility.instance;

  loadData() async {
    await Future.delayed(Duration(seconds: 2));

    _interface.showLoader();

    var response = await _companyProvider.getCompany();
    if (response.isErr()) {
      _interface.showErrorToast(response.unwrapErr().message);
      _interface.closeLoader();
      return;
    }

    response = await _associatesProvider.getAssociates();
    if (response.isErr()) {
      _interface.showErrorToast(response.unwrapErr().message);
      return;
    }

    _interface.closeLoader();

    _interface.navigateTo(HomeView.route);
  }
}
