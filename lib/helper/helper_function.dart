import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //Keys
  static String userNamekey = 'USERNAMEKEY';
  static String userEmailKey = 'EMAILKEY';
  static String phoneNumberKey = "PHONENUMBERKEY";
  static String xpub1Key = "XPUB1";
  static String xpub2Key = "XPUB2";
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String spaceNameKey = 'SPACENAMEKEY';
  static String authIDKey = 'AUTHIDKEY';
  static String deviceIDKey = 'DEVICEIDKEY';
  static String deviceEntryKey = 'DEVICEENTRYKEY';
  static String deviceNameKey = "DEVICENAMEKEY";
  static String deviceTypeKey = ' DEVICETYPEKEY';
  static String deviceModelKey = 'DEVICEMODELKEY';

  ///save prefs

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserEmailSF(String email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, email);
  }

  static Future<bool> saveXpub1SF(String xpub1) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(xpub1Key, xpub1);
  }

  static Future<bool> saveXpub2SF(String xpub2) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(xpub2Key, xpub2);
  }

  static Future<bool> saveSpaceNameSF(String spaceName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(spaceNameKey, spaceName);
  }

  static Future<bool> savePhoneNumberSF(String phoneNumber) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(phoneNumberKey, phoneNumber);
  }

  static Future<bool> saveAuthIDSF(String authID) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(authIDKey, authID);
  }

  static Future<bool> saveDeviceIDSF(String deviceId) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(deviceIDKey, deviceId);
  }

  static Future<bool> saveDeviceEntry(String entry) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(deviceEntryKey, entry);
  }

  static Future<bool> saveDeviceNameSF(String deviceName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(deviceNameKey, deviceName);
  }

  static Future<bool> saveDeviceTypeSF(String deviceType) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(deviceTypeKey, deviceType);
  }

  static Future<bool> saveDeviceModel(String deviceModel) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(deviceModelKey, deviceModel);
  }

  /// get saved prefs////
  static Future<bool?> userLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNamekey);
  }

  static Future<String?> getAuthIDfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(authIDKey);
  }

  static Future<String?> getXpub1fromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(xpub1Key);
  }

  static Future<String?> getXpub2fromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(xpub2Key);
  }

  static Future<String?> getPhoneNumberfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(phoneNumberKey);
  }

  static Future<String?> getSpaceNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(spaceNameKey);
  }

  static Future<String?> getDeviceIDfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(deviceIDKey);
  }

  static Future<String?> getDeviceEntryFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(deviceEntryKey);
  }

  static Future<String?> getDeviceNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(deviceNameKey);
  }

  static Future<String?> getDeviceTypeFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(deviceTypeKey);
  }

  static Future<String?> getDeviceModelFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(deviceModelKey);
  }
}
