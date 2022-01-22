import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class SettingsCountriesItem extends StatelessWidget {
  const SettingsCountriesItem({Key? key}) : super(key: key);

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
              const Text(
                'Country',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (newMatch.opponentCountry != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      newMatch.opponentCountry!.name,
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
          FocusScope.of(context).unfocus();
          showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadius),
                topRight: Radius.circular(Dimensions.borderRadius),
              ),
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: (Country country) {
              newMatch.setOpponentCountry(country);
            },
          );
        },
      ),
    );
  }
}
