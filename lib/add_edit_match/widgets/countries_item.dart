import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class CountriesItem extends StatelessWidget {
  const CountriesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Country',
          label: newMatch.opponentCountryString,
          showError: newMatch.showError(newMatch.opponentCountry),
        ),
        onTap: () {
          showCountriesDialog(context, newMatch);
        },
      ),
    );
  }

  void showCountriesDialog(BuildContext context, ValidationMatch newMatch) {
    FocusScope.of(context).unfocus();
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Theme.of(context).canvasColor,
        textStyle: const TextStyle(fontSize: 16),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
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
  }
}
