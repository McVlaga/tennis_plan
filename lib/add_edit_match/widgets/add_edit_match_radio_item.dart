import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';

class AddEditMatchRadioItem extends StatelessWidget {
  const AddEditMatchRadioItem(
      {required this.itemTitle,
      required this.choiceLabel,
      required this.dialogBody,
      Key? key})
      : super(key: key);

  final String itemTitle;
  final String choiceLabel;
  final Widget dialogBody;

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingTwo),
          child: Row(
            children: [
              Text(
                itemTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (choiceLabel.isNotEmpty)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      choiceLabel,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        onTap: () {
          showDialog(context, newMatch);
        },
      ),
    );
  }

  void showDialog(BuildContext context, AMatch newMatch) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (builder) {
        return ChangeNotifierProvider.value(
          value: newMatch,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 300),
            child: dialogBody,
          ),
        );
      },
    );
  }
}
