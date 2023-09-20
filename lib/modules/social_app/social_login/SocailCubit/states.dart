
abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}


class SocialLoginSuccessState extends SocialLoginStates{
  String uid ;
  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginStates{
  String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginChangePasswordState extends SocialLoginStates{}