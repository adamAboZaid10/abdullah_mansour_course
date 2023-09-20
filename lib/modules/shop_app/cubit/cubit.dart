
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/category_model.dart';
import 'package:oneproject/models/shop_app/favorites_model.dart';
import 'package:oneproject/models/shop_app/get_favorites.dart';
import 'package:oneproject/models/shop_app/home_model.dart';
import 'package:oneproject/models/shop_app/login_model.dart';
import 'package:oneproject/modules/basics/counter/home/home_screen.dart';
import 'package:oneproject/modules/shop_app/cubit/states.dart';
import 'package:oneproject/modules/shop_app/screens/category_screen.dart';
import 'package:oneproject/modules/shop_app/screens/favorite_screen.dart';
import 'package:oneproject/modules/shop_app/screens/home_screen.dart';
import 'package:oneproject/modules/shop_app/screens/settings_screen.dart';
import 'package:oneproject/network/end_points.dart';
import 'package:oneproject/network/remote/dio_helper.dart';

import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit  get(BuildContext? context) => BlocProvider.of(context!);

  int currentIndex = 0;

  List<Widget> screens =
  [
    const ShopProductScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNave(index){
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;

  late Map<int? , bool?> ? favorites ={};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token:token,
       ).then((value){
         homeModel = HomeModel.fromJson(value.data);
         homeModel!.data!.products!.forEach((element) {
           favorites!.addAll({
             element.id : element.inFavorites,
           });
         });
         print(favorites.toString());
         emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoryModel? categoryModel;
  void getCategoryData()
  {
    DioHelper.getData(
        url: CATEGORY,
        token: token,
       ).then((value){
         categoryModel = CategoryModel.fromJson(value.data);
         printFullText(categoryModel.toString());
         printFullText('${categoryModel!.data}');
         emit(ShopSuccessCategoryDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }


  FavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId){
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoriteDataState());
    DioHelper.postData(
        url: FAVORITE,
        token: token,
        data: {
          'product_id': productId,
        },

    ).then((value){
      changeFavoritesModel  =FavoritesModel.fromJson(value.data);
      if(changeFavoritesModel!.status ==false) {
        favorites![productId] = !favorites![productId]!;
      }else{
        getFavoriteData();
      }
      print(value.data);
      emit(ShopSuccessChangeFavoriteDataState(changeFavoritesModel!));
    }).catchError((error){
      favorites![productId] = !favorites![productId]!;

      emit(ShopErrorChangeFavoriteState());
    });
  }


  GetFavoriteModel? favoriteModel;
  void getFavoriteData()
  {
    emit(ShopLoadingGetFavoriteDataState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value){
      favoriteModel = GetFavoriteModel.fromJson(value.data);
      printFullText(favoriteModel.toString());
      printFullText('${favoriteModel!.data}');
      emit(ShopSuccessGetFavoriteDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoriteDataState());
    });
  }


  ShopLoginModel? settingsModel;
  void getSettingsData()
  {
    emit(ShopLoadingGetSettingsDataState());
    DioHelper.getData(
      url: PROFILE,
     token: token,
    ).then((value){
      settingsModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetSettingsDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetSettingsDataState());
    });
  }

  void getUpDateData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpDateDataState());
    DioHelper.putData(
      url: UPDATE_DATE,
     token: token,
      data:
      {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value){
      settingsModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpDateDataState(settingsModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUpDateDataState());
    });
  }

}
