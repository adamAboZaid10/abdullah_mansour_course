abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String error;
  SocialGetAllUserErrorState(this.error);
}


class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{
  final String error;
  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}


class SocialBottomNavChangeState extends SocialStates{}

class SocialAddPostState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}


class SocialProfileCoverPickedSuccessState extends SocialStates{}
class SocialProfileCoverPickedErrorState extends SocialStates{}


class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}


class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}


class SocialUpdateUserDataLoadingState extends SocialStates{}
class SocialUpdateUserDataErrorState extends SocialStates{}
//create post

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialPostPickedSuccessState extends SocialStates{}
class SocialPostPickedErrorState extends SocialStates{}


class SocialRemovePostState extends SocialStates{}


class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}
