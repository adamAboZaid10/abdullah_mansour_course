import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/modules/social_app/screens/edit_screen/edit_screen.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:oneproject/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel =SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                     Align(
                      alignment: AlignmentDirectional.topCenter,
                      child:  Image(
                        image: NetworkImage('${userModel!.cover}'),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,

                      ),
                    ),
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60,
                        backgroundImage:  NetworkImage(
                          '${userModel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Text('${userModel.name}',style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20
              ),),
              const SizedBox(height: 10,),
              Text(
                '${userModel.bio}',style: Theme.of(context).textTheme.bodyText2,),
              const SizedBox(height: 20,),
              Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: const Column(
                        children:
                        [
                          Text(
                            '100',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child:const Column(
                        children:
                        [
                          Text(
                            '255',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child:const Column(
                        children:
                        [
                          Text(
                            '10K',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child:const Column(
                        children:
                        [
                          Text(
                            '65',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followings',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children:
                [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child:const Text('Add Photos',style: TextStyle(color: defaultColor),),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context,  EditProfileScreen());
                    },
                    child: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children:
                [
                  OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                      },
                      child: const Text(
                        'Subscribe',
                      ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: ()
                    {
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                    },
                    child: const Text(
                      'unSubscribe',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
