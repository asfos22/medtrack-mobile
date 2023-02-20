import 'dob_model.dart';

class AuthModel {
  static final AuthModel? _appData = AuthModel._internal();

  String? _phone;
  String? _fullName;
  String? _email;
  String? _countryCode;
  String? _gender;
  String? _ghanaCardCountryCode;
  String? _ghanaSerialSixCode;
  String? _ghanaSerialThreeCode;
  String? _pin;
  String? _userToken;
  String? _ghanaCardNumber;
  DoBModel? _doBModel;
  List<int> selectedNotification = <int>[];

  factory AuthModel() => _appData!;

  AuthModel._internal();

  String? getPhone() => _phone;

  set setPhone(String? phone) => _phone = phone;

  void resetPhone() => setPhone = '';

  //--
  String? getFullName() => _fullName;

  set setFullName(String? name) => _fullName = name;

  void resetFullName() => setFullName = '';

  //--
  String? getEmail() => _email;

  set setEmail(String? email) => _email = email;

  void resetEmail() => setEmail = '';

  //--

  String? getGender() => _gender;

  set setGender(String? gender) => _gender = gender;

  void resetGender() => setGender = '';

  //--
  String? getGhanaCardCode() => _ghanaCardCountryCode;

  set setGhanaCardCode(String? ghanaCardCode) =>
      _ghanaCardCountryCode = ghanaCardCode;

  void resetGhanaCardCode() => _ghanaCardCountryCode = '';

  String? getGhanaCardNumber() => _ghanaCardNumber;

  set setGhanaCardNumber(String? ghanaCardNumber) =>
      _ghanaCardNumber = ghanaCardNumber;

  void resetGhanaCardNumber() => _ghanaCardNumber = '';

  //--

  String? getGhanaSerialSixCode() => _ghanaSerialSixCode;

  set setGhanaSerialSixCode(String? ghanaSerialSixCode) =>
      _ghanaSerialSixCode = ghanaSerialSixCode;

  void resetGhanaSerialSixCode() => setGhanaSerialSixCode = '';

  //--
  String? getGhanaSerialThreeCode() => _ghanaSerialThreeCode;

  set setGhanaSerialThreeCode(String? ghanaSerialThreeCode) =>
      _ghanaSerialThreeCode = ghanaSerialThreeCode;

  void resetGhanaSerialThreeCode() => setGhanaSerialThreeCode = '';

  //--
  String? getUserToken() => _userToken;

  set setUserToken(String? userToken) => _userToken = userToken;

  void resetUserToken() => setUserToken = '';

  //--

  String? getPin() => _pin;

  set setPin(String? pin) => _pin = pin;

  void resetPin() => setPin = '';

  //--

  String? getCountryCode() => _countryCode;

  set setCountryCode(String? countryCode) => _countryCode = countryCode;

  void resetCountryCode() => setCountryCode = '';

  //--

  DoBModel? getDobModel() => _doBModel;

  set setDobModel(DoBModel? doBModel) => _doBModel = doBModel;

  void reset() {
    resetPhone();
  }
}
