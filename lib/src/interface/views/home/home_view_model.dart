import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;
  bool companyViewIsExpenses = true;

  switchSelectedIndex(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  switchCompanyViewMode(bool isDashboard) {
    final previousCompanyViewIsExpenses = companyViewIsExpenses;

    if (isDashboard && !previousCompanyViewIsExpenses) {
      companyViewIsExpenses = true;
    }

    if (!isDashboard && previousCompanyViewIsExpenses) {
      companyViewIsExpenses = false;
    }

    switchSelectedIndex(0);
  }
}
