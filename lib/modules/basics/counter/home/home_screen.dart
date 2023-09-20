import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text("abdo",
        ),
        actions:
        [
          IconButton(
              onPressed: ()
              {
                print('hello abdo');
              },
              icon:const Icon(Icons.add, )
          ),
          IconButton(
          icon:  const Icon(
            Icons.mail,
          ),
          onPressed:()
          {
            print('Enter your email');
          }
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 90,
      ),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.all(50),
            child:  Container(
              decoration:const  BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(30)
                ),
              ) ,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 200,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Image(
                    image: NetworkImage('https://images.unsplash.com/photo-1615744455875-7ad33653e8c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                   color: Colors.black.withOpacity(.5),
                    width: double.infinity,
                    child:const Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child:  Text('hello hi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,

                      ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}