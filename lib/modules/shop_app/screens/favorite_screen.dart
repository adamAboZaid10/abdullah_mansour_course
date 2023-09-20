import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/get_favorites.dart';
import 'package:oneproject/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class FavoriteScreen  extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context ,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoriteDataState ,
          builder:(context)=> ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder:(context ,index) => buildPruductItem(cubit.favoriteModel!.data!.data?[index].product,context),
            separatorBuilder: (context ,index) => Container(
              width: double.infinity,
              color: Colors.blueGrey,
              height: 1,
            ),
            itemCount:cubit.favoriteModel!.data!.data!.length,
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    ) ;
}
}

