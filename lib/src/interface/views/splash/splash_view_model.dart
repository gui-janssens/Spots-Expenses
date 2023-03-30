import 'package:stacked/stacked.dart';

import '../../../data/providers/providers.dart';
import '../../utility/utility.dart';
import '../views.dart';

class SplashViewModel extends BaseViewModel {
  final _companyProvider = CompanyProvider.instance;
  final _interface = InterfaceUtility.instance;

  loadData() async {
    await Future.delayed(Duration(seconds: 2));

    _interface.showLoader();
    final response = await _companyProvider.getCompany();
    _interface.closeLoader();

    if (response.isErr()) {
      _interface.showErrorToast(response.unwrapErr().message);
      return;
    }
    _interface.navigateTo(HomeView.route);
  }
}
