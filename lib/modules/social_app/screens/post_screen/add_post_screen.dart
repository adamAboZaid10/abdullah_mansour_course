import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/layout/social_app/social_layout.dart';


class NewAddPost extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context,state){
        var postImage =SocialCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create post'),
            actions:
            [
              MaterialButton(
                  onPressed: ()
                  {
                    var now = DateTime.now();
                    if(SocialCubit.get(context).postImage==null)
                    {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  },
                child: const Text(
                    'post',
                  style: TextStyle(color: Colors.blue,fontSize: 17),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10,),
                Row(
                  children:
                  [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:  NetworkImage(
                          'https://img.freepik.com/free-photo/handsome-man-presenting-something_1368-87.jpg?w=360&t=st=1693048274~exp=1693048874~hmac=5242bb7c7f466d75e1a3390c1546290db5f79ac9f03e16329bd6df4c4c3586bf'),
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      'Adam Mohamed',
                      style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,

                  children: [
                    Image(
                      image:FileImage(postImage!) ,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,

                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.close,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Expanded(
                      child: MaterialButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                        child: const Row(children:
                        [
                          Icon(Icons.photo,color: Colors.blue,),
                          SizedBox(width: 5,),
                          Text('add photo',style: TextStyle(color: Colors.blue),),
                        ],),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                       child: TextButton(
                           onPressed:(){},
                           child: const Text('# tags',style: TextStyle(color: Colors.blue),)),
                     ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
