import 'dob_model.dart';

class HealthDataModel {
  static final HealthDataModel? _healthDataModelData =
      HealthDataModel._internal();

  String? _personalPhone;
  String? _personalCountryCode;
  String? _facilityPhone;
  String? _facilityCountryCode;
  String? _hospitalFacilityFullName;
  String? _hospitalFacilityPhysicianFullName;
  String? _email;

  String? _bloodGroup;
  String? _allergies;
  String? _knownPreExitingCondition;
  String? _currentMedication;
  String? _height;
  String? _weight;
  String? _bloodPressure;
  DoBModel? _doBModel;
  List<int> selectedNotification = <int>[];

  factory HealthDataModel() => _healthDataModelData!;

  HealthDataModel._internal();

  String? getPPhone() => _personalPhone;

  set setPPhone(String? phone) => _personalPhone = phone;

  void resetPhone() => setPPhone = '';

  //--

  //--

  String? getPCountryCode() => _personalCountryCode;

  set setPCountryCode(String? countryCode) =>
      _personalCountryCode = countryCode;

  void resetPCountryCode() => setPCountryCode = '';

  //--

  String? getBloodGroup() => _bloodGroup;

  set setBloodGroup(String? bloodGroup) => _bloodGroup = bloodGroup;

  void resetBloodGroup() => setBloodGroup = '';


  //--
  String? getBloodPressure() => _bloodPressure;

  set setBloodPressure(String? bloodPressure) => _bloodPressure = bloodPressure;

  void resetBloodPressure() => setBloodPressure = '';

  //--

  String? getAllergies() => _allergies;

  set setAllergies(String? allergies) => _allergies = allergies;

  void resetAllergies() => setAllergies = '';

  //-
  String? getKnownPreExistingCondition() => _knownPreExitingCondition;

  set setKnownPreExistingCondition(String? knownPreExistingCon) =>
      _knownPreExitingCondition= knownPreExistingCon;

  void resetKnownPreExisting() => setKnownPreExistingCondition = '';

  //--
  String? getCurrentMedication() => _currentMedication;

  set setCurrentMedication(String? cMedications) =>
      _currentMedication = cMedications;

  void resetCurrentMedication() => setCurrentMedication = '';

  //--
  String? getHeight() => _height;

  set setHeight(String? height) => _height = height;

  void resetHeight() => setHeight = '';

  //--
  String? getWeight() => _weight;

  set setWeight(String? weight) => _weight = weight;

  void resetWeight() => setWeight = '';

  //--

  String? getFacilityName() => _hospitalFacilityFullName;

  set setFacilityName(String? hFName) => _hospitalFacilityFullName = hFName;

  void resetFacilityName() => setFacilityName = '';

  //--

  String? getPhysicianName() => _hospitalFacilityPhysicianFullName;

  set setPhysicianName(String? physicianName) =>
      _hospitalFacilityPhysicianFullName = physicianName;

  void resetPhysicianName() => setPhysicianName = '';

  //--
  String? getFacilityPhone() => _facilityPhone;

  set setFacilityPhone(String? facilityPhone) => _facilityPhone = facilityPhone;

  void resetFacilityPhone() => setFacilityPhone = '';

  //--

  String? getFCountryCode() => _facilityCountryCode;

  set setFCountryCode(String? countryCode) =>
      _facilityCountryCode = _facilityCountryCode;

  void resetFCountryCode() => setFCountryCode = '';

  void reset() {
    resetPhone();
  }
}
