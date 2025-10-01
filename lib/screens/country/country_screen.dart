import 'package:flutter/material.dart';
import 'package:graph_ql_demos/models/country_model.dart';
import 'package:graph_ql_demos/repositories/country_repository.dart';
import 'package:graph_ql_demos/services/country_service.dart';

import '../../models/country_model.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late CountryRepository countryRepository;

  @override
  void initState() {
    super.initState();
    countryRepository = CountryRepository(CountryService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Country")),
      body: FutureBuilder<List<CountryModel>>(
        future: countryRepository.getAllCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No countries found"));
          } else {
            final countries = snapshot.data!;
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  title: Text(country.name),
                  subtitle: Text(country.continent.name),
                  leading: Text(country.emoji, style: const TextStyle(fontSize: 24)),
                  trailing: Text(country.code),
                );
              },
            );
          }
        },
      ),
    );
  }
}
