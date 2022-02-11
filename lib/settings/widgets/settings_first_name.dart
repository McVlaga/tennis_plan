import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/user_info.dart';
import 'settings_item_widget.dart';

class SettingsFirstName extends StatelessWidget {
  const SettingsFirstName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(builder: (_, userInfo, __) {
      return SizedBox(
        height: Dimensions.addMatchDialogInputHeight,
        child: InkWell(
          child: SettingsItemWidget(
            title: 'First name',
            label: userInfo.firstName ?? 'Roger',
            showError: false,
          ),
          onTap: () {
            showDialog(context, userInfo);
          },
        ),
      );
    });
  }

  void showDialog(BuildContext ctx, UserInfo userInfo) {
    TextEditingController controller = TextEditingController();
    controller.text = userInfo.firstName ?? 'Roger';
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
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: Dimensions.paddingFour,
            right: Dimensions.paddingFour,
            top: Dimensions.paddingFour,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your first name',
                ),
              ),
              const SizedBox(height: Dimensions.paddingOne),
              TextField(
                autofocus: true,
                controller: controller,
                textCapitalization: TextCapitalization.sentences,
                onChanged: null,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'First name',
                ),
              ),
              const SizedBox(height: Dimensions.paddingOne),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: Dimensions.paddingTwo),
                  TextButton(
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        userInfo.setFirstName(controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingTwo),
            ],
          ),
        );
      },
    );
  }
}
