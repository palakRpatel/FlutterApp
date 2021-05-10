import 'package:shared_preferences/shared_preferences.dart';

class MySharePreference {
  SharedPreferences prefs;

  MySharePreference() {
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  setIsFirstTimeLoad() async {
    prefs.setBool('firstTimeLoad', true);
  }

  getIsFirstLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    if(prefs.containsKey('firstTimeLoad')){
      return true;
    }
    return false;
  }
}
