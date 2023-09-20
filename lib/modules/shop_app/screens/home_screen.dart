
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/category_model.dart';
import 'package:oneproject/models/shop_app/home_model.dart';
import 'package:oneproject/modules/shop_app/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/cubit/states.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:oneproject/shared/styles/colors.dart';

class ShopProductScreen  extends StatelessWidget {
  const ShopProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates >(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoriteDataState)
        {
          if(state.model.status ==false)
          {
            showToast(
                text: "${state.model.message}",
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition:cubit.homeModel != null &&cubit.categoryModel != null,
            builder:(context) => productBuilder(cubit.homeModel,cubit.categoryModel,context) ,
            fallback: (context)=> const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget productBuilder(HomeModel? homeModel,CategoryModel? categoryModel,context) =>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
            items:homeModel!.data!.banners!.map((e) =>  Image(
              image:NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),).toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3,),
              autoPlayAnimationDuration:const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        const SizedBox(height: 10,),
         Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10.0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Categories : ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) => buildCategory(categoryModel!.data!.data?[index]),
                    separatorBuilder: (context,index) => const SizedBox(width: 10,),
                    itemCount: categoryModel!.data!.data!.length,
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                  'Products : ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 3,
            childAspectRatio: 1/1.49,
            children:List.generate(
              homeModel.data!.products!.length,
                  (index) => buildGridProduct(homeModel.data!.products![index],context) ,
            ),
          ),
        ),

      ],
    ),
  );

  Widget buildGridProduct(Product? model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  height: 200,
                  image: NetworkImage('${model!.image}'),
                  width: double.infinity,
                ),
                if(model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style:  const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color:defaultColor,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      if(model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style:  TextStyle(
                            height: 1.3,
                            fontSize: 10,
                            color: Colors.grey[700],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites?[model.id]==true ? defaultColor:Colors.grey,
                        radius: 15,
                        child: IconButton(
                            onPressed: ()
                            {
                              ShopCubit.get(context).changeFavorites(model.id);

                            },
                            icon: const Icon(Icons.favorite_border,size: 16,)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategory(Datum? model) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
       Image(
        image: NetworkImage('${model!.image}'),
        width: 100,
        height: 100,
      ),
      Text(
        '${model.name}',
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.black.withOpacity(.7),
        ),
      ),
    ],
  );
}