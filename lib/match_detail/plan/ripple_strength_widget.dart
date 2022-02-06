import 'package:flutter/material.dart';
import 'models/strengths.dart';
import 'opponent_info/add_edit_strength_dialog.dart';
import '../../constants/constants.dart';

class RippleStrengthWidget extends StatelessWidget {
  const RippleStrengthWidget({
    Key? key,
    required this.strengths,
    required this.strength,
  }) : super(key: key);

  final Strengths? strengths;
  final String strength;

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
        return AddEditStrengthDialog(strengths: strengths!, strength: strength);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (strengths != null) showAddEditItemDialog(context);
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
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 4),
              ),
              const SizedBox(width: 16),
              Flexible(child: Text(strength)),
            ],
          ),
        ),
      ),
    );
  }
}
