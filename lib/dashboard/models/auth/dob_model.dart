class DoBModel {
  static final DoBModel? _doBModel = DoBModel._internal();

  String? _day;
  String? _month;
  String? _year;
  String? _dob;

  factory DoBModel() => _doBModel!;

  DoBModel._internal();

  String? getDay() => _day;

  set setDay(String? day) => _day = day;

  void resetDay() => setDay = '';

  //--
  String? getMonth() => _month;

  set setMonth(String? month) => _month = month;

  void resetMonth() => setMonth = '';

  //--

  String? getYear() => _year;

  set setYear(String? year) => _year = year;

  void resetYear() => setYear = '';

  //--
  String? getDoB() => _dob;

  set setDoB(String? dob) => _dob = dob;

  void resetDoB() => setDoB = '';

  void reset() {
    resetDay();
    resetMonth();
    resetYear();
    resetDoB();
  }
}
