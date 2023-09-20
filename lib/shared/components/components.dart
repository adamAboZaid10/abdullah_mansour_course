import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oneproject/modules/news_screens/search/web_view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/shop_app/get_favorites.dart';
import '../../modules/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';


Widget defaultButton ({
  double width =double.infinity,
  Color backgroundColor =Colors.blue,
  required Function function,
  required String text,
  bool isUpperCase =true,
})=>Container(
width: width,
color:backgroundColor,
child: MaterialButton(
onPressed:() {function;},
child:  Text(
   isUpperCase? text.toUpperCase() :text,
style: const TextStyle(
fontSize: 25,
color: Colors.white,
),
),
),
);
Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTaap,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefixIcon,
  IconData? suffix,
  Function? suffixPressed,
  bool obscure =false,
}) =>TextFormField(

  controller:controller ,
  keyboardType: type ,
  onFieldSubmitted: (String? s)
  {
    onSubmit!(s!);
  },
  onTap: ()
  {
    onTaap!;
  },
  onChanged: (String? s){
    onChange!(s!);
  },
  validator: validator,
  obscureText: obscure,
  decoration:  InputDecoration(
  labelText: label,
    border: const OutlineInputBorder(),
    prefixIcon: Icon(prefixIcon),
    suffixIcon: suffix != null ? IconButton(
      onPressed: ()
      {
        suffixPressed!();
      },
        icon: Icon(suffix),
    ) : null,

  ),
);


Widget buildTaskItem ()=> const Padding(
      padding:  EdgeInsets.all(20),
         child: Row(
          children:
           [
              CircleAvatar(
                radius: 40,
                child: Text(
                  '12 pm',),
                ),
              SizedBox(
                width: 20,
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                        Text(
                              'task title',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                          ),),
                        SizedBox(
                              height: 5,
                                  ),
                        Text(
                          '2 april 2022',
                          style: TextStyle(
                            fontSize: 10,
                          ),),
                  ],
              ),
           ],
      ),);



Widget  buildArticleItem(article,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

        padding: const EdgeInsets.all(20),

        child: Row(

          children:

          [

            Container(

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(20),

                image: DecorationImage(

                  fit: BoxFit.cover,

                  image: NetworkImage(

                    '${article['urlToImage']}',

                  ),),),

              width: 150,

              height: 150,

            ),

            const SizedBox(

              width: 20,

            ),

            Expanded(

              child: Container(

                height: 150,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:

                  [

                    Expanded(

                        child: Text(

                          '${article['title']}',

                          maxLines: 4,

                          style: Theme.of(context).textTheme.bodyText1,

                        )),

                    Text(

                        '${article['publishedAt']}',

                      style:const TextStyle(

                        color: Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),),
);



Widget articleBuilder(list,context,{isSearch = false})=> ConditionalBuilder(
  condition: list.length > 0,

  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) => buildArticleItem(list[index],context),
    separatorBuilder: (BuildContext context, int index) => Container(
      width: double.infinity,
      color: Colors.blueGrey,
      height: 1,
    ),
    itemCount: 10,
  ),
  fallback: (context) =>isSearch ?Container() : const Center(child:  CircularProgressIndicator()),

);

void navigateTo(context , widget) =>  Navigator.push(
  context,
MaterialPageRoute(builder:(context)=> widget ,
),);

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget),
        (route) => false,
);

void showToast ({
  required String text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{
  SUCCESS , ERROR ,WARNING
}

Color chooseToastColor (ToastStates state){
  Color color;
  switch(state)
  {
      case ToastStates.SUCCESS :
        color = Colors.green;
        break;
      case ToastStates.ERROR :
        color = Colors.red;
        break;
      case ToastStates.WARNING :
        color = Colors.amber;
        break;
  }
  return color;
}






Widget buildPruductItem( model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                height: 200,
                image: NetworkImage('${model!.image}'),
                width: double.infinity,
              ),
              if(model.discount != 0 && isOldPrice)
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
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:  const TextStyle(
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
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
                  if(model.discount  != 0 && isOldPrice)
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
                    backgroundColor : ShopCubit.get(context).favorites?[model.id] == true ? defaultColor :Colors.grey,
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
  ),
);


// Widget defaultAppBar({
//   // required context,
//   List<Widget>? actions,
//   String? title,
// }) => AppBar(
//   title: Text(title!),
//   actions:actions,
// );