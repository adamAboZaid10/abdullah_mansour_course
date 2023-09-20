
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/modules/shop_app/screens/search/cubit/states.dart';
import 'package:oneproject/network/remote/dio_helper.dart';
import 'package:oneproject/shared/components/constants.dart';

import '../../../../../models/shop_app/search_model.dart';
import '../../../../../network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>
{

   SearchCubit() : super((SearchInitialStates()));

   static SearchCubit  get(BuildContext? context) => BlocProvider.of(context!);

   SearchModel? model;

   void shopSearch(String text,)
   {
     emit(SearchLoadingStates());
     DioHelper.postData(
         url: SEARCH,
         token: token,
         data: {
           'text':text,
         }
     ).then((value){
       model = SearchModel.fromJson(value.data);
       print(value.data);
       emit(SearchSuccessStates());
     }).catchError((error){
       print(error.toString());
       emit(SearchErrorStates());
     });
   }

}