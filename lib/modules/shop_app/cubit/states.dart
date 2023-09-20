import 'package:oneproject/models/shop_app/favorites_model.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../models/shop_app/search_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNav extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoryDataState extends ShopStates{}

class ShopErrorCategoryDataState extends ShopStates{}

class ShopSuccessChangeFavoriteDataState extends ShopStates{
  final FavoritesModel model;
  ShopSuccessChangeFavoriteDataState(this.model);
}


class ShopChangeFavoriteDataState extends ShopStates{}

class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopSuccessGetFavoriteDataState extends ShopStates{}

class ShopLoadingGetFavoriteDataState extends ShopStates{}

class ShopErrorGetFavoriteDataState extends ShopStates{}

class ShopSuccessGetSettingsDataState extends ShopStates{}

class ShopLoadingGetSettingsDataState extends ShopStates{}

class ShopErrorGetSettingsDataState extends ShopStates{}


class ShopSuccessUpDateDataState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUpDateDataState(this.loginModel);
}

class ShopLoadingUpDateDataState extends ShopStates{}

class ShopErrorGetUpDateDataState extends ShopStates{}
