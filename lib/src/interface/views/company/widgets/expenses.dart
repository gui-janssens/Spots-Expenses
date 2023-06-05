import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/providers.dart';
import '../../../utility/utility.dart';
import '../company_view_model.dart';

class Expenses extends StatefulWidget {
  final CompanyViewModel viewModel;

  const Expenses(this.viewModel, {super.key});

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
          itemsAvailable(_companyProvider),
          itemsConsumed(_companyProvider),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _loansExpanded = !_loansExpanded;
                  });
                },
                leading: Icon(Icons.compare_arrows_rounded),
                title: Text('Loans'),
              );
            },
            body: Column(
              children: List<Widget>.generate(
                _companyProvider.company.loans.length,
                (index) {
                  return ListTile(
                    title: Text(
                        'R\$ ${_companyProvider.company.loans[index].value}'),
                    subtitle: Text(
                        'Gotten by: ${AssociatesProvider.instance.associates.firstWhere((element) => element.id == _companyProvider.company.loans[index].associateId).name}\nAt: ${DateFormat('dd/mm/yyyy HH:mm').format(_companyProvider.company.loans[index].dateTime)}'),
                  );
                },
              ),
            ),
            isExpanded: _loansExpanded,
          ),
        ],
      ),
    );
  }

  ExpansionPanel itemsConsumed(CompanyProvider _companyProvider) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          onTap: () {
            setState(() {
              _itemsConsumedExpanded = !_itemsConsumedExpanded;
            });
          },
          leading: Icon(Icons.attach_money),
          title: Text('Items consumed'),
        );
      },
      body: Column(
        children: List<Widget>.generate(
          _companyProvider.company.itemsConsumed.length,
          (index) {
            return ListTile(
              title:
                  Text(_companyProvider.company.itemsConsumed[index].itemName),
              subtitle: Text(
                  'Consumed by: ${AssociatesProvider.instance.associates.firstWhere((element) => element.id == _companyProvider.company.itemsConsumed[index].associateId).name}\nAt: ${DateFormat('dd/mm/yyyy HH:mm').format(_companyProvider.company.itemsConsumed[index].dateTime)}'),
            );
          },
        ),
      ),
      isExpanded: _itemsConsumedExpanded,
    );
  }

  ExpansionPanel itemsAvailable(CompanyProvider _companyProvider) {
    return ExpansionPanel(
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
        children: List<Widget>.generate(_companyProvider.company.items.length,
                (index) {
              final item = _companyProvider.company.items[index];
              return Column(
                children: [
                  ListTile(
                    leading: item.photoUrl != null
                        ? Image.network(item.photoUrl!)
                        : null,
                    title: Text(item.name),
                    subtitle: Text(
                      'In stock: ${item.quantity}\nCurrent price: R\$ ${item.averagePrice.toStringAsFixed(2).replaceAll('.', ',')}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              widget.viewModel.popConsumeItemDialog(item),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text('Consume'),
                        ),
                        SizedBox(width: 7.5),
                        ElevatedButton(
                          onPressed: () =>
                              widget.viewModel.popRefillItemDialog(item),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: Text('Refill'),
                        ),
                        SizedBox(width: 7.5),
                        TextButton(
                          onPressed: () => widget.viewModel.deleteItem(item),
                          child: widget.viewModel.deletingItemId == item.id
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.red),
                                )
                              : Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            }) +
            [
              InkWell(
                onTap: widget.viewModel.popCreateNewItemDialog,
                child: Container(
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
                        'Create new item',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
      ),
      isExpanded: _itemsExpanded,
    );
  }
}
