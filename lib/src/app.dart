import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../src/router.dart';
import 'data/providers/providers.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AssociatesProvider.instance),
          ChangeNotifierProvider.value(value: CompanyProvider.instance),
        ],
        child: MaterialApp.router(
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          title: 'Spots Expense',
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          builder: BotToastInit(),
        ),
      ),
    );
  }
}
