
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/models/social/social_chat_model.dart';
import 'package:oneproject/models/social/social_user_model.dart';
import 'package:oneproject/modules/social_app/screens/home_screen/home.dart';
import 'package:oneproject/modules/social_app/screens/post_screen/add_post_screen.dart';
import 'package:oneproject/modules/social_app/screens/settings_screen/settings.dart';
import 'package:oneproject/modules/social_app/screens/users_screen/users.dart';
import 'package:oneproject/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/social/social_post_model.dart';
import '../../../modules/social_app/screens/chat_screen/chat.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get()
        .then((value){
          print(value.data());
          userModel = SocialUserModel.fromJson(value.data());
          emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> titles =
  [
    'Home',
    'Chats',
    'Add post',
    'Users',
    'Settings',
  ];
  List<Widget> screens =
  [
    const HomeScreen(),
    const ChatScreen(),
     NewAddPost(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  void changeBottomNav(int index)
  {
    if(index == 1)
    {
     getAllUsers();
    }
    if(index == 2){
      emit(SocialAddPostState());
    }else{
      currentIndex = index;
      emit(SocialBottomNavChangeState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }


  File? coverImage;
  Future getCoverImage() async
  {
    final XFile?  pickedFile = await picker.pickImage(
        source: ImageSource.camera,
    );

    if (pickedFile!.path.isNotEmpty) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialProfileCoverPickedErrorState());
    }
  }




  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
})
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
                profile: value,
            );
            emit(SocialUploadProfileImageSuccessState());
          }).catchError((error){
            print(error.toString());
            emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  })
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void upDateUserImages({
//   required String name,
//   required String bio,
//   required String phone,
// })
//   {
//     emit(SocialUpdateUserDataLoadingState());
//     if(coverImage != null)
//     {
//       uploadCoverImage();
//     }
//     else if (profileImage != null)
//     {
//       uploadProfileImage();
//     } else if (profileImage != null&&coverImage != null){}
//     else{
//       updateUser(name: name, bio: bio, phone: phone);
//     }
//
//   }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? profile,
    String? cover,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uid:userModel!.uid,
      image:profile?? userModel!.image,
      cover: cover?? userModel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;
  Future getPostImage() async
  {
    final XFile?  pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile!.path.isNotEmpty) {
      postImage = File(pickedFile.path);
      emit(SocialPostPickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialPostPickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostState());
  }
  //create post
  void uploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        createPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );
        emit(SocialCreatePostSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uid:uid,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  List<PostModel> posts =[];
  List<String> postId =[];
  List<int> likes =[];

  void getPostData()
  {
    FirebaseFirestore
        .instance
        .collection('posts')
        .get()
        .then((value){
          value.docs.forEach((element) {
            element.reference.collection('likes')
            .get()
            .then((value){
              likes.add(value.docs.length);
              postId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
            .catchError((error){});
          });
          emit(SocialGetPostSuccessState());
    }).catchError((error){
      emit(SocialGetPostErrorState(error));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .set({
      'like':true,
    })
        .then((value){
          emit(SocialLikePostSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> allUser =[];

  void getAllUsers()
  {
    if(allUser.isEmpty) {
      FirebaseFirestore
          .instance.collection('users')
          .get()
          .then((value){
        value.docs.forEach((element) {
          if(element.data()['uId'] != uid){
            allUser.add(SocialUserModel.fromJson(element.data()));
          }
          emit(SocialGetAllUserSuccessState());
        });
      })
          .catchError((error){
            print(error.toString());
        emit(SocialGetAllUserErrorState(error.toString()));
      });

    }

  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
}){
    ChatModel model = ChatModel(
      text: text,
      senderId: uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('chats')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
    .then((value){
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('message')
        .add(model.toMap())
        .then((value){
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }


  List<ChatModel> messages = [];

  void getMessages({
    required String receiverId,

  })
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats')
      .doc(receiverId)
      .collection('message')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
         messages = [];
        event.docs.forEach((element) {
          messages.add(ChatModel.fromJson(element.data()));
        });
         emit(SocialGetMessageSuccessState());
  });
}
}