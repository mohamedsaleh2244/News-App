import 'package:flutter/cupertino.dart';

class CountryProv extends ChangeNotifier{
  String countryId = "Eg";
  changeCountry(String id){
    countryId = id;
    notifyListeners();
  }
}