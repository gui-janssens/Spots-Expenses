import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../locator.dart';
import '../../router.dart';

class BlurredLoader extends StatelessWidget {
  const BlurredLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        color: Colors.grey.withOpacity(0.6),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}

class DialogAction {
  final String title;
  final Function() onPressed;
  final Color? color;

  DialogAction({
    required this.title,
    required this.onPressed,
    this.color = Colors.black,
  });
}

class InterfaceUtility {
  static InterfaceUtility get instance => locator<InterfaceUtility>();
  final navigationKey = GlobalKey<NavigatorState>();
  static BuildContext get ctx =>
      goRouter.routerDelegate.navigatorKey.currentContext!;

  /// Shows a blurred loader on top of the app
  showLoader() {
    BotToast.showCustomLoading(
      animationDuration: const Duration(milliseconds: 300),
      animationReverseDuration: const Duration(milliseconds: 300),
      backButtonBehavior: BackButtonBehavior.ignore,
      allowClick: false,
      ignoreContentClick: true,
      toastBuilder: (_) => const BlurredLoader(),
    );
  }

  /// Closes the blurred loader if it exists
  closeLoader() {
    BotToast.closeAllLoading();
  }

  /// Navigates to a page
  void navigateTo(String routeName,
      {dynamic arguments,
      Map<String, String> params = const <String, String>{},
      Map<String, dynamic> queryParams = const <String, dynamic>{}}) {
    ctx.goNamed(
      routeName,
      params: params,
      queryParams: queryParams,
    );
    // return navigationKey.currentState!.pushNamed(
    //   routeName,
    //   arguments: arguments,
    // );
  }

  /// Removes current page from the stack
  goBack([dynamic result]) {
    ctx.pop();
  }

  showErrorToast(String message) {
    return showToast(
      backgroundColor: Colors.red,
      message: message,
    );
  }

  Future<dynamic> showDialogMessage({
    required String title,
    required String message,
    double backgroundOpacity = 0,
    Axis actionsDirection = Axis.horizontal,
    required List<DialogAction> actions,
    bool isDismissible = true,
  }) {
    var dialog = AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(100, 102, 105, 1),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          if (actionsDirection == Axis.horizontal)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                actions.length,
                (index) => Expanded(
                  child: InkWell(
                    onTap: actions[index].onPressed,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: index == actions.length - 1
                            ? null
                            : const Border(
                                right: BorderSide(
                                  color: Color(0xFFEDEFF2),
                                  width: 1,
                                ),
                              ),
                      ),
                      child: Center(
                        child: Text(
                          actions[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: actions[index].color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                actions.length,
                (index) => InkWell(
                  onTap: actions[index].onPressed,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: index == actions.length - 1
                          ? null
                          : const Border(
                              bottom: BorderSide(
                                color: Color(0xFFEDEFF2),
                                width: 1,
                              ),
                            ),
                    ),
                    child: Center(
                      child: Text(
                        actions[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          color: actions[index].color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
    return showDialog(
      context: navigationKey.currentContext!,
      barrierColor: Colors.grey.withOpacity(backgroundOpacity),
      builder: (context) => isDismissible
          ? dialog
          : WillPopScope(
              onWillPop: () async => false,
              child: dialog,
            ),
      barrierDismissible: isDismissible,
    );
  }

  Future<dynamic> showCustomDialog({
    required Widget widget,
    double backgroundOpacity = .75,
    bool removeFocusOnScreenTap = false,
    bool isDismissible = true,
  }) {
    var dialog = AlertDialog(
      insetPadding: const EdgeInsets.all(25),
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: widget,
    );

    return showDialog(
      context: navigationKey.currentContext!,
      barrierColor: Colors.grey.withOpacity(backgroundOpacity),
      builder: (context) => isDismissible
          ? dialog
          : WillPopScope(
              onWillPop: () async => false,
              child: InkWell(
                onTap: () => removeFocusOnScreenTap
                    ? FocusScope.of(context).requestFocus(FocusNode())
                    : {},
                child: dialog,
              ),
            ),
      barrierDismissible: isDismissible,
    );
  }

  /// Shows a snackbar with custom color and message
  showToast({
    required String message,
    required Color backgroundColor,
  }) {
    BotToast.showCustomText(
      onlyOne: true,
      align: Alignment.topRight,
      toastBuilder: (_) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            constraints: BoxConstraints(minWidth: SizerUtil.width / 5),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
