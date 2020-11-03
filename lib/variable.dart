import 'package:flutter/cupertino.dart';
import 'package:sms/sms.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController secretId = TextEditingController();
TextEditingController phoneNumber = TextEditingController();
String mobileImei = 'Unknown';
String uniqueId = "Unknown";
bool progressBar = false;
bool getNotify = false;

List<Color> colorMain = [Color(0xFF6dd5ed), Color(0xFF2193b0)];
//For loc Screen
TextEditingController pin1 = new TextEditingController();
TextEditingController pin2 = new TextEditingController();
TextEditingController pin3 = new TextEditingController();
TextEditingController pin4 = new TextEditingController();
TextEditingController phones = new TextEditingController();
TextEditingController otp = new TextEditingController();

final focus1 = FocusNode();
final focus2 = FocusNode();
final focus3 = FocusNode();
final focus4 = FocusNode();
final focus5 = FocusNode();
var pass1;
var pass2;
var pass3;
var pass4;
void imputPref(String pin1, String pin2, String pin3, String pin4) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('pin1', pin1);
  prefs.setString('pin2', pin2);
  prefs.setString('pin3', pin3);
  prefs.setString('pin4', pin4);
}

Future<String> getDate() async {
  final prefs = await SharedPreferences.getInstance();
  pass1 = prefs.getString('pin1') ?? '';
  pass2 = prefs.getString('pin2') ?? '';
  pass3 = prefs.getString('pin3') ?? '';
  pass4 = prefs.getString('pin4') ?? '';

  String password = pass1 + pass2 + pass3 + pass4;
  return password;
}

Future<void> deletePassword() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('pin1', '');
  prefs.setString('pin2', '');
  prefs.setString('pin3', '');
  prefs.setString('pin4', '');
}

//Otp Generation
int _otp, _minOtpValue, _maxOtpValue;
void generateOtp([int min = 1000, int max = 9999]) {
  //Generates four digit OTP by default
  _minOtpValue = min;
  _maxOtpValue = max;
  _otp = _minOtpValue + Random().nextInt(_maxOtpValue - _minOtpValue);
}

void sendOtp(String phoneNumber,
    [String messageText,
    int min = 1000,
    int max = 9999,
    String countryCode = '+91']) {
  //function parameter 'message' is optional.
  generateOtp(min, max);
  SmsSender sender = new SmsSender();
  String address = (countryCode ?? '+91') + phoneNumber;

  sender.sendSms(new SmsMessage(
      address, messageText ?? 'Your OTP is : ' + _otp.toString()));
}

bool resultChecker(int enteredOtp) {
  //To validate OTP
  return enteredOtp == _otp;
}
