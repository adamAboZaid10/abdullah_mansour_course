import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 15.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:
            const[
              CircleAvatar(
               radius: 20.0,
               backgroundImage:NetworkImage(
                'https://images.unsplash.com/photo-1615744455875-7ad33653e8c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
               ) ,
             ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                'Chats',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight:FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.blue,
            child: IconButton(
                onPressed: (){},
                icon:const Icon(
                    Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.blue,
              child: IconButton(
                  onPressed: (){},
                  icon: const Icon(
                      Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              padding:const EdgeInsets.all(5.0),
              child: Row(
                children:
                const[

                  Icon(
                    Icons.search,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'search',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context ,index)=>buildStory(),
                    separatorBuilder: (context,index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: 20,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context ,index)=>buildChat(),
                  separatorBuilder: (context ,index)=>const SizedBox(
                    height: 10.0,
                  ),
                  itemCount:20,
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildStory() => Container(
  width: 60.0,
  child: const Column(
  children:
  [
  Stack(
  alignment: AlignmentDirectional.bottomEnd,
  children: [
  CircleAvatar(
  radius: 30.0,
  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1615744455875-7ad33653e8c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
  ),
  Padding(
  padding: EdgeInsetsDirectional.only(
  bottom: 3,
  end: 3,
  ),
  child: CircleAvatar(
  radius: 6.0,
  backgroundColor: Colors.green,
  ),
  ),
  ],
  ),
  SizedBox(
  height: 10,
  ),
  Text(
  'Adam mohamed',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  ),
  );
  Widget buildChat()=>  const Row(
    children: [Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1615744455875-7ad33653e8c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: 3,
            end: 3,
          ),
          child: CircleAvatar(
            radius: 6.0,
            backgroundColor: Colors.green,
          ),
        ),
      ],
    ),
      SizedBox(
        width: 15.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(
              'abdo mohamed',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  child: Text(
                    'hello my name is abd elmalik i love egypt',
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                CircleAvatar(
                  radius: 3.0,
                  backgroundColor: Colors.black,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '2:28 PM'
                  ,
                ),

              ],
            ),
          ],
        ),
      ),
    ],
  );
}
