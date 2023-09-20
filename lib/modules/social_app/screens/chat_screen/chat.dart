import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/models/social/social_user_model.dart';
import 'package:oneproject/modules/social_app/screens/chat_screen/chat_details_screen.dart';
import 'package:oneproject/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).allUser.isNotEmpty,
            builder: (context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>itemBuild(SocialCubit.get(context).allUser[index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(color: Colors.grey,height: 1,width: 1,),
              ),
              itemCount: SocialCubit.get(context).allUser.length,
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget itemBuild(SocialUserModel? model,context)=> InkWell(
    onTap: ()
    {
      navigateTo(context,  ChatDetailsScreen(
        userModel: model,
      ) );
    },
    child:  Padding(
      padding: const EdgeInsets.all(20.0),
      child:  Row(
        children:
        [
          CircleAvatar(
            backgroundImage: NetworkImage(
                '${model!.image}'),
            radius: 25,
          ),
          const SizedBox(width: 10,),
          Text(
            '${model.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
