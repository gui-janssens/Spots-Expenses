import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/providers/providers.dart';
import '../../../utility/utility.dart';
import '../home_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final HomeViewModel viewModel;

  CustomAppBar(
    this.viewModel,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      actions: [
        Row(
          children: [
            InkWell(
              onTap: () => viewModel.switchSelectedIndex(0),
              child: PopupMenuButton(
                color: AppColors.primary,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      'Expenses',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: viewModel.selectedIndex == 0 &&
                                viewModel.companyViewIsExpenses
                            ? 15
                            : 14,
                        fontWeight: viewModel.selectedIndex == 0 &&
                                viewModel.companyViewIsExpenses
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                    onTap: () => viewModel.switchCompanyViewMode(true),
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Accounting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: viewModel.selectedIndex == 0 &&
                                !viewModel.companyViewIsExpenses
                            ? 15
                            : 14,
                        fontWeight: viewModel.selectedIndex == 0 &&
                                !viewModel.companyViewIsExpenses
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                    onTap: () => viewModel.switchCompanyViewMode(false),
                  ),
                ],
                child: Text(
                  'Spots',
                  style: TextStyle(
                    fontSize: viewModel.selectedIndex == 0 ? 15 : 14,
                    fontWeight: viewModel.selectedIndex == 0
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        Row(
          children: List.generate(
            AssociatesProvider.instance.associates.length,
            (index) => Row(
              children: [
                NavItem(
                  index: index + 1,
                  selectedIndex: viewModel.selectedIndex,
                  switchSelectedIndex: viewModel.switchSelectedIndex,
                  text: AssociatesProvider.instance.associates[index].name,
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        Hero(
          tag: '1',
          child: Image.asset(
            'assets/images/spots_white.png',
            width: SizerUtil.width / 5,
          ),
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class NavItem extends StatelessWidget {
  final int selectedIndex;
  final Function(int) switchSelectedIndex;
  final int index;
  final String text;

  const NavItem({
    required this.index,
    required this.selectedIndex,
    required this.switchSelectedIndex,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => switchSelectedIndex(index),
      splashColor: Colors.white.withOpacity(.1),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: selectedIndex == index ? 15 : 14,
            fontWeight:
                selectedIndex == index ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
