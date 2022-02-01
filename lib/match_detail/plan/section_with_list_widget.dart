import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';

class SectionWithListWidget extends StatelessWidget {
  const SectionWithListWidget({
    required this.title,
    required this.titleIcon,
    required this.items,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData titleIcon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                titleIcon,
                size: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(top: 4),
                  ),
                  SizedBox(width: 16),
                  Flexible(child: Text(items[index])),
                ],
              );
            },
            itemCount: items.length,
            separatorBuilder: (_, index) {
              return Divider(
                height: 24,
                thickness: 1,
                indent: 25,
              );
            },
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
