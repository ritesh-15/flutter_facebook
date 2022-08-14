import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInputWidget extends StatelessWidget {
  final Function(String?)? onChanged;

  const CodeInputWidget({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        style: Theme.of(context).textTheme.headline5,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0))),
        onChanged: (value) {
          if (value.length == 1) {
            onChanged!(value);
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
