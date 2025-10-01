import 'package:graph_ql_demos/models/country_model.dart';
import 'package:graph_ql_demos/services/country_service.dart';

class CountryRepository {
  final CountryService countryService;

  CountryRepository(this.countryService);

  Future<List<CountryModel>> getAllCountries() async {
    final data = await countryService.getCountries();
    return data;
  }
}
