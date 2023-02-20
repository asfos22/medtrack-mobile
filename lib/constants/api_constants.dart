class APIConstants {
  static const String headerAuth = "SOME-USER-TOKEN";
  static const String octetStreamEncoding = "application/octet-stream";
  static const String contentTypeApplicationJson = "application/json";
  static const String apiVersion = "v1";
  static const String slash = "/";
  static const String api = "api";
  static const String prePendUrl = "/m";

  static String apiBaseUrl =
      "https://dev.medtrack.io"; //slash + api + slash + apiVersion;

  static const String login = "/login";
  static const String registration = "/register";
  static const String password = "/password";
  static const String reset = "/reset";
  static const String confirm = "/confirm";
  static const String change = "/change";
  static const String role = "/role";
  static const String roles = "/roles";
  static const String patient = "/patient";
  static const String profile = "profile";
  static const String passwordReset = "$password $reset";
  static const String prescriptions = 'prescriptions';
  static const String notificationSettings = "notification-settings";
  static const String visits = "visits";
  static const String access = "access";
  static const String investigations ="investigations";
  static const String healthData ="health-data";
  static const String profilePicture = "profile-picture";

  static const String users = "/users";
  static const String user = "/user";
  static const String subscription = "/subscription";

  //FCM subscription
  static const String subScribeFCM =
      "$apiVersion$slash$api$users$user$subscription";

  static const String getRequestMethod = "GET";
  static const String postRequestMethod = "POST";
  static const String deleteRequestMethod = "DELETE";
  static const String putRequestMethod = "PUT";
  static const String multipartRequest = "MULTI_PART_REQUEST";

  // -- group

  //-- prescription
  static const String prescriptionEndpoint =
      '$prePendUrl$patient$slash$prescriptions';

  // -- fetch profile
  static const String fetchProfileEndpoint =
      '$prePendUrl$patient$slash$profile';

  // -- notification settings
  static const String notificationSettingEndpoint =
      '$prePendUrl$patient$slash$notificationSettings';

  // -- clinical visits
  static const String clinicalVisitsEndpoint =
      '$prePendUrl$patient$slash$visits';

  // -- diagnostics
  static const String diagnosticsEndpoint =
      '$prePendUrl$patient$slash$investigations';

  // -- Fetch / Update patient health data
  static const healthDataEndpoint =
      '$prePendUrl$patient$slash$healthData';


}
