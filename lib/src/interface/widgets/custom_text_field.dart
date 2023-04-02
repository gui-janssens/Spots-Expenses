import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Function(String) onChanged;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final bool enabled;
  final TextInputType keyboardType;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool hasError;
  final FocusNode? focusNode;
  final Function()? onSuffixIconPressed;
  final Widget? suffix;
  final Color? backgroundColor;
  final String? errorText;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final TextAlign? textAlign;
  final String? counter;
  final TextCapitalization textCapitalization;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    this.counter,
    this.hintText,
    this.focusNode,
    this.minLines = 1,
    this.textInputAction,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign,
    this.controller,
    this.errorText,
    this.onSuffixIconPressed,
    this.suffix,
    this.backgroundColor,
    this.prefix,
    this.onFieldSubmitted,
    this.obscureText = false,
    required this.onChanged,
    this.inputFormatters,
    this.hasError = false,
    this.initialValue,
    this.enabled = true,
    this.keyboardType = TextInputType.multiline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: !enabled ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: hasError ? Colors.red : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          if (prefix != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: prefix!,
            ),
          Expanded(
            child: TextFormField(
              textCapitalization: textCapitalization,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              textInputAction: textInputAction,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              controller: controller,
              textAlign: textAlign ?? TextAlign.start,
              onChanged: (t) => onChanged(t),
              inputFormatters: inputFormatters ?? [],
              keyboardType: keyboardType,
              initialValue: initialValue,
              minLines: minLines,
              maxLines: maxLines,
              cursorColor: Colors.black,
              obscureText: obscureText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                counter: counter != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(counter!),
                      )
                    : null,
                hoverColor: Colors.transparent,
                // prefixIconConstraints: BoxConstraints(
                //   maxHeight: 25,
                //   maxWidth: 30,
                //   minWidth: 30,
                // ),
                // prefix: prefix,
                suffixIconConstraints: const BoxConstraints(
                    maxHeight: 30, maxWidth: 100, minWidth: 30),
                suffixIcon: suffix != null
                    ? InkWell(
                        onTap: onSuffixIconPressed,
                        child: suffix,
                      )
                    : null,
                errorText: errorText,
                suffixIconColor: Colors.green,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                fillColor: !enabled ? Colors.transparent : Colors.white,
                filled: true,
                enabled: enabled,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = '';

    for (var i = 0; i < newValue.text.length; i++) {
      var currentCharacter = newValue.text[i];
      if (i == 0) {
        currentCharacter = currentCharacter.toUpperCase();
      } else {
        var previousCharacter = newValue.text[i - 1];
        if (previousCharacter == ' ') {
          currentCharacter = currentCharacter.toUpperCase();
        }
      }
      text += currentCharacter;
    }
    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    var newSelection = newValue.selection;
    var truncated = newValue.text;

    var value = newValue.text;

    if (value.contains('.') &&
        value.substring(value.indexOf('.') + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == '.') {
      truncated = '0.';

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
