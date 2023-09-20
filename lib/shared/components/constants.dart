import '../../modules/shop_app/shop_login/login.dart';
import '../../network/remote/cache_helper.dart';
import 'components.dart';

List<Map> tasks =[];



void singOut(context){
  CacheHelper.removeData(key: 'token')
      .then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token ='';
  var uid;

//get

// https://newsapi.org/v2/top-headlines?country=us&apiKey=74107c250d034d5e905c7d1993e05e7c


// base url : https://newsapi.org/   سيرفير

// method(url) : v2/top-headlines?  ازي ههيتحرك جوه السيرفير

// queries : country=eg&apiKey=74107c250d034d5e905c7d1993e05e7c

// POST
// UPDATE
// DELETE


// base url : https://newsapi.org/

// method(url) : v2/everything?

// queries :  q=tesla&apiKey=74107c250d034d5e905c7d1993e05e7c
