import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/modules/shop_app/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/cubit/states.dart';
import 'package:oneproject/modules/shop_app/screens/search/search_screen.dart';
import 'package:oneproject/modules/shop_app/shop_login/login.dart';
import 'package:oneproject/network/remote/cache_helper.dart';
import 'package:oneproject/shared/components/components.dart';

class ShopLayout  extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Malik Store',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context,  SearchScreen());
                  },
                  icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNave(index);
            },
            items:
            const [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home',),
              BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Category',),
              BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'Favorite',),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'Settings',),
            ],
          ),
        );
      },
    );
  }
}
