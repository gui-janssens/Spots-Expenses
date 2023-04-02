import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/providers.dart';
import '../../../utility/utility.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  bool _itemsExpanded = false;
  bool _itemsConsumedExpanded = false;
  bool _loansExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, _companyProvider, _) => ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          if (index == 0) {
            setState(() {
              _itemsExpanded = !_itemsExpanded;
            });
            return;
          }

          if (index == 1) {
            setState(() {
              _itemsConsumedExpanded = !_itemsConsumedExpanded;
            });
            return;
          }
          setState(() {
            _loansExpanded = !_loansExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _itemsExpanded = !_itemsExpanded;
                  });
                },
                title: Text('Items available'),
                leading: Icon(Icons.shopping_bag_outlined),
              );
            },
            body: Column(
              children: List<Widget>.generate(
                      _companyProvider.company.items.length, (index) {
                    return ListTile(
                      title: Text(_companyProvider.company.items[index].name),
                      subtitle: Text(
                          'In stock: ${_companyProvider.company.items[index].quantity}\n Current price: ${_companyProvider.company.items[index].averagePrice}'),
                    );
                  }) +
                  [
                    Container(
                      height: 65,
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 7.5),
                          Text(
                            'Add new item',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
            ),
            isExpanded: _itemsExpanded,
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _itemsConsumedExpanded = !_itemsConsumedExpanded;
                  });
                },
                title: Text('Items consumed'),
              );
            },
            body: ListTile(
              title: Text('Item 2 child'),
              subtitle: Text('Details goes here'),
            ),
            isExpanded: _itemsConsumedExpanded,
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _loansExpanded = !_loansExpanded;
                  });
                },
                title: Text('Loans'),
              );
            },
            body: ListTile(
              title: Text('Item 2 child'),
              subtitle: Text('Details goes here'),
            ),
            isExpanded: _loansExpanded,
          ),
        ],
      ),
    );
  }
}
