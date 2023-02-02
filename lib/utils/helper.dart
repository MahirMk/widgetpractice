import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  static String spIsUserLogin = "isLoggedIn";
  static String spUserData = "isLoginResponse";
  static String spFriend = "friend";
  static String spImage = "Img";
  static String spUid = "uid";

  static SharedPreferences? preferences;




  /// saving data to shared preference

  /*save when user is log in*/
  static Future<bool?> saveUserLogin(bool data) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.setBool(spIsUserLogin, data);
  }
//*save when user is user data*/
  static Future<bool?>  saveUserData(String? data) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.setString(spUserData, data!);
  }


  /*save friend response*/
  static Future<bool?> saveFriend(int? res) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.setInt(spFriend, res!);
  }

  static Future<bool?> saveImages(String? image) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.setString(spImage, image!);
  }

  //*save uid*/
  static Future<bool?> saveUidData(String? data) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.setString(spUid, data!);
  }
  /// fetching data from shared preference

/*get user is log in or not*/
  static Future<bool?>  getUserLogin() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getBool(spIsUserLogin)?? false;
  }

  /*get userData*/
  static Future<String?>  getUserData() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(spUserData);
  }

/*get friend value */
  static Future<int?>  getFriend() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getInt(spFriend);
  }
  /* getImage */
  static Future<String?> getImages() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(spImage);
  }
  //*get uid *//
  static Future<String?>  getUidData() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(spUid);
  }

  ///clean shared preference
  static Future<void> spClean() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.remove(spIsUserLogin);
    preferences!.remove(spUserData);
    preferences!.remove(spFriend);
    preferences!.remove(spUid);
  }

  /*clean signed images*/
  // static Future<void> spCleanSignature() async {
  //   preferences = await SharedPreferences.getInstance();
  //   preferences!.remove(spSign);
  // }


}
