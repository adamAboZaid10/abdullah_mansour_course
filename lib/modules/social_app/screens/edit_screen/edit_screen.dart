import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/shared/components/components.dart';

import '../../../../layout/social_app/cubit/social_cubit.dart';
import '../../../../layout/social_app/cubit/social_state.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel =SocialCubit.get(context).userModel;
        var profileModel =SocialCubit.get(context).profileImage;
        var coverModel =SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions:
            [
              TextButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone:phoneController.text ,
                    );
                  },
                  child: const Text('update'),
              ),
              const SizedBox(width: 10,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [
                  if(state is SocialUpdateUserDataLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child:  Stack(
                            alignment: AlignmentDirectional.topEnd,

                            children: [
                              Image(
                                image:coverModel==null ?FileImage(File('${userModel.cover}')):FileImage(coverModel) ,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,

                              ),
                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const  CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 63,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child:  Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: profileModel == null ? FileImage(File('${userModel.image}')):FileImage(profileModel),
                              ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 15,
                                      ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                    Row(
                      children:
                      [
                        if(SocialCubit.get(context).profileImage!=null)
                          Expanded(
                            child: Column(
                              children: [
                                MaterialButton(
                                color: Colors.blue,
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  child:const  Text(
                                      'upload profile',
                                      style: TextStyle(
                                        color: Colors.white,)
                                    ,),
                                ),
                                // const SizedBox(height: 5,),
                                // const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(width: 7,),
                        if(SocialCubit.get(context).coverImage!=null)
                          Expanded(
                            child: Column(
                              children: [
                                MaterialButton(
                                  color: Colors.blue,
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  child:const  Text(
                                    'upload cover',
                                    style: TextStyle(
                                      color: Colors.white,)
                                    ,),
                                ),
                                // const SizedBox(height: 5,),
                                // const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller:nameController ,
                    keyboardType:  TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                    decoration: const InputDecoration(
                      label:Text('name'),
                      icon: Icon( Icons.person,),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller:bioController ,
                    keyboardType:  TextInputType.text,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label:Text('bio'),
                      icon: Icon( Icons.info_outline,),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller:phoneController ,
                    keyboardType:  TextInputType.phone,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label:Text('phone'),
                      icon: Icon( Icons.phone,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}