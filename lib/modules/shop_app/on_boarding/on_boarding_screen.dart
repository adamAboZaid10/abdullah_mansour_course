import 'package:flutter/material.dart';
import 'package:oneproject/modules/shop_app/shop_login/login.dart';
import 'package:oneproject/network/remote/cache_helper.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});


}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding =
  [
    BoardingModel(
        image: 'assets/images/boarding.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body',
    ),
    BoardingModel(
        image: 'assets/images/boarding.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body',
    ),
    BoardingModel(
        image: 'assets/images/boarding.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value) {
          if(value == true)
          {
            navigateAndFinish(context,  ShopLoginScreen());
          }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: submit,
              child:const Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast =false;
                    });
                  }
                },
                controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:(context,index) => builderBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    effect:  const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                    dotWidth: 10,
                    spacing: 5,

                  ),
                    controller: boardController,
                    count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast )
                    {
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child:const Icon(Icons.arrow_forward_ios) ,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builderBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
          child: Image(image: AssetImage(model.image))),
      const SizedBox(height: 30,),
      Text(
        model.title,
        style:const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 15,),
      Text(
         model.body,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
