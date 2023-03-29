import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../src/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp.router(
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        title: 'Spots Expense',
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
        builder: BotToastInit(),
      ),
    );
  }
}
