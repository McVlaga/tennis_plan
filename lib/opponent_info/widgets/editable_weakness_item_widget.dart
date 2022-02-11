import 'package:flutter/material.dart';
import '../dialogs/add_edit_weakness_dialog.dart';

import '../../../constants/constants.dart';
import '../models/weaknesses.dart';

class EditableWeaknessItemWidget extends StatelessWidget {
  const EditableWeaknessItemWidget({
    Key? key,
    required this.weaknesses,
    required this.weakness,
  }) : super(key: key);

  final Weaknesses? weaknesses;
  final String weakness;

  void showAddEditItemDialog(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Theme.of(ctx).canvasColor,
      builder: (_) {
        return AddEditWeaknessDialog(
            weaknesses: weaknesses!, weakness: weakness);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (weaknesses != null) showAddEditItemDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingTwo,
            vertical: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 4),
              ),
              const SizedBox(width: 16),
              Flexible(child: Text(weakness)),
            ],
          ),
        ),
      ),
    );
  }
}
