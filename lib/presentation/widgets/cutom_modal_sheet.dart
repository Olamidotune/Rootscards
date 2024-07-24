import 'package:flutter/material.dart';
import 'package:rootscards/model/country_model.dart';

class CountryModalSheet extends StatefulWidget {
  final String selectedCountryFlag;
  final String selectedCountryCode;

  const CountryModalSheet(
      {super.key,
      required this.selectedCountryFlag,
      required this.selectedCountryCode});

  @override
  State<CountryModalSheet> createState() => _CountryModalSheetState();
}

class _CountryModalSheetState extends State<CountryModalSheet> {
  String selectedCountryCode = '';
  String selectedCountryFlag = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: countryModel.length,
          itemBuilder: (context, index) {
            final country = countryModel[index];
            return ListTile(
              leading: Image.asset(
                "assets/flags/${country['code'].toLowerCase()}.png",
                width: 32,
                height: 32,
              ),
              title: Text(country['name']),
              onTap: () {
                setState(() {
                  selectedCountryCode = country['dial_code'];
                  selectedCountryFlag =
                      "assets/flags/${country['code'].toLowerCase()}.png";
                });
                Navigator.pop(context);
              },
            );
          },
        )
      ],
    );
  }
}
