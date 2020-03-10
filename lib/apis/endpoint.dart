class EndPoint {
  static String SELF_CARE_BASE_URL = "http://212.100.86.49:8088/api/mobile/";


  static String postLoginValidate(){
    return '$SELF_CARE_BASE_URL''Validate';
  }
  static String getCompleteCyberPayNew(){
    return '$SELF_CARE_BASE_URL''CompleteCyberPayNew';
  }
  static String postCyberPayModel(){
    return '$SELF_CARE_BASE_URL''PostCyberPayModel';
  }

  static String getSingleIAccount(){
    return '$SELF_CARE_BASE_URL''ActiveSession';
  }
static String postForgotPassword(){
    return '$SELF_CARE_BASE_URL''ForgotPassword';
  }

}