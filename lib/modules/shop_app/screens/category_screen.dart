import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/category_model.dart';
import 'package:oneproject/modules/shop_app/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/cubit/states.dart';

class CategoryScreen  extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
       listener: (context ,state){},
      builder: (context,state){
         var cubit = ShopCubit.get(context);
         return ListView.separated(
           shrinkWrap: true,
           physics: const BouncingScrollPhysics(),
             itemBuilder:(context ,index) => buildItem(cubit.categoryModel!.data!.data?[index]),
             separatorBuilder: (context ,index) => Container(
               width: double.infinity,
               color: Colors.blueGrey,
               height: 1,
             ),
             itemCount:cubit.categoryModel!.data!.data!.length,
         );
      },
    );
  }

  Widget buildItem(Datum? model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child:Row(
      children:
      [
        Image(
          image: NetworkImage('${model!.image}'),
          height: 90,
          width: 90,
        ),
        const Spacer(),
        Text(
          '${model.name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );
}
