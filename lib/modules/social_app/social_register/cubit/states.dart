abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}


class SocialRegisterSuccessState extends SocialRegisterStates{}

class SocialRegisterErrorState extends SocialRegisterStates {
   String error;

   SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates{}

class SocialCreateUserErrorState extends SocialRegisterStates{
   String error;
   SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangePasswordState extends SocialRegisterStates{}