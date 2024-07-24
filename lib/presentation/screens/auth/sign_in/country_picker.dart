import 'package:flutter/material.dart';
import 'package:rootscards/model/country_model.dart';

class CountryPicker extends StatefulWidget {
  static const String routeName = 'test';

  const CountryPicker({super.key});
  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Map<String, dynamic>? selectedCountry;
  List<Map<String, dynamic>> searchCountry = [];

  @override
  void initState() {
    super.initState();

    searchCountry = countryModel;
  }

  void _runFilter(String enterKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enterKeyword.isEmpty) {
      results = countryModel;
    } else {
      results = countryModel
          .where((searchedCountries) => searchedCountries['name']
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      searchCountry = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Picker'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => _runFilter(value),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchCountry.length,
              itemBuilder: (context, index) {
                final country = searchCountry[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/flags/${country['code'].toLowerCase()}.png',
                    width: 32,
                    height: 32,
                  ),
                  title: Text(country['name']),
                  onTap: () {
                    setState(() {
                      selectedCountry = country;
                    });
                  },
                );
              },
            ),
          ),
          if (selectedCountry != null) ...[
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Country: ${selectedCountry!['name']}'),
                  Text('Dial Code: ${selectedCountry!['dial_code']}'),
                  Text('Code: ${selectedCountry!['code']}'),
                  Text('Languages: ${selectedCountry!['language'].join(', ')}'),
                  Text('Nationality: ${selectedCountry!['nationality']}'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
