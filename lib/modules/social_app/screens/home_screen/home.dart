import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/models/social/social_post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context)=>SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [
                  const Card(
                    elevation: 6,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:
                      [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/handsome-man-presenting-something_1368-87.jpg?w=360&t=st=1693048274~exp=1693048874~hmac=5242bb7c7f466d75e1a3390c1546290db5f79ac9f03e16329bd6df4c4c3586bf'),
                          width: double.infinity,
                          height: 150,
                          alignment: Alignment.centerLeft,

                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ListView.separated(
                    //i use the physics with never and shrinkWrap with true because i use the single child scroll view in big collum.
                    physics:const NeverScrollableScrollPhysics() ,
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildHomePerson(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=>Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=>const Center(child:CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget buildHomePerson(PostModel? model,context,index)=> Card(
    elevation: 6,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:
          [
             CircleAvatar(
              radius: 30,
              backgroundImage:  NetworkImage(
                  '${model!.image}'),
            ),
            const SizedBox(width: 10,),
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Row(
                    children:
                    [
                      Text(
                        '${model.name}',
                        style: const TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.star,color: Colors.blue,)
                    ],
                  ),
                  Text('${model.dateTime}'),

                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
          ],
        ),
        const SizedBox(height: 15,),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 15,),
         Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            '${model.text}',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        // SizedBox(
        //   width: double.infinity,
        //   child: Wrap(
        //     alignment: WrapAlignment.start,
        //     children:
        //     [
        //       MaterialButton(
        //         onPressed: (){},
        //       child:const Text(
        //         '#flutter',
        //         style: TextStyle(
        //             color:Colors.blue,
        //           fontSize: 16
        //         ),),
        //     ),
        //     ],
        //   ),
        // ),
        if(model.postImage != '')
          Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration:  BoxDecoration(

              image:DecorationImage(image: NetworkImage(
                  '${model.postImage}')
                ,
                alignment: Alignment.centerLeft,

              ),) ,
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children:
            [
              InkWell(
                onTap: (){},
                child:  Row(
                  children: [
                    const Icon(Icons.heart_broken_sharp,size: 17,color:Colors.blue,),
                    const SizedBox(width: 5,),
                    Text(
                      '${SocialCubit.get(context).likes[index]}',
                      style:const TextStyle(fontSize: 16)
                      ,),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: (){},
                child: const Row(
                  children: [
                    Icon(Icons.message,size: 17,color: Colors.blue,),
                    SizedBox(width: 5,),
                    Text('0 comment ',style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children:
            [
               CircleAvatar(
                radius: 20,
                backgroundImage:NetworkImage(
                    '${SocialCubit.get(context).userModel!.image}') ,
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                    child:const Text('write a comment '),
                  onTap: (){},
                ),
              ),
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
                child: const Row(
                  children: [
                    Icon(Icons.heart_broken,size: 17,color: Colors.blue,),
                    SizedBox(width: 5,),
                    Text('like ',style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
