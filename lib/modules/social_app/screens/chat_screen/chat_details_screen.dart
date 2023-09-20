import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/models/social/social_chat_model.dart';
import 'package:oneproject/models/social/social_user_model.dart';

class ChatDetailsScreen  extends StatelessWidget {
  SocialUserModel? userModel;
   ChatDetailsScreen({Key? key,this.userModel}) : super(key: key);
   var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context){
          SocialCubit.get(context).getMessages(
              receiverId: '${userModel!.uid}',
          );
          return BlocConsumer<SocialCubit,SocialStates>(
            listener: (context,state){},
            builder: (context,state){
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children:
                    [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${userModel!.image}'
                        ),
                        radius: 20,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                          '${userModel!.name}'
                      ),
                    ],
                  ),
                ),
                body:ConditionalBuilder(
                    condition: SocialCubit.get(context).messages.isNotEmpty, 
                    builder: (context)=> Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children:
                        [
                         Expanded(
                           child: ListView.separated(
                               itemBuilder: (context,index)
                               {
                                 var message = SocialCubit.get(context).messages[index];
                                 if(SocialCubit.get(context).userModel!.uid == message.senderId) {
                                   return buildMessage(message);
                                 }else{
                                   return buildMyMessage(message);
                                 }
                               }, 
                               separatorBuilder: (context,index)=>const SizedBox(
                                 height: 15,
                               ),
                               itemCount: SocialCubit.get(context).messages.length,
                           ),
                         ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(.3),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10
                                    ),
                                    child: TextFormField(
                                      controller: textController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here...',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context)
                                          .sendMessage(
                                        receiverId: '${userModel!.uid}',
                                        dateTime: DateTime.now().toString(),
                                        text: textController.text,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), 
                    fallback: (context)=>  const Center(child: CircularProgressIndicator(),),
                ),
              );
            },
          );
        }
    );
  }
  Widget buildMessage(ChatModel? model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          bottomEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
        '${model!.text}'
      ),
    ),
  );
  Widget buildMyMessage(ChatModel? model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          bottomStart: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text('${model!.text}'),
    ),
  );
}
