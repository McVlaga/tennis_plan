import 'package:flutter/material.dart';
import '../constants/constants.dart';

class RadioButton extends StatelessWidget {
  final String label;
  final Enum? valueType;
  final Enum? value;
  final void Function() function;

  const RadioButton({
    required this.label,
    required this.valueType,
    required this.value,
    required this.function,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        onTap: function,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimensions.paddingOne),
          child: Row(
            children: <Widget>[
              Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: valueType,
                value: value!,
                onChanged: (_) {
                  function();
                },
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
