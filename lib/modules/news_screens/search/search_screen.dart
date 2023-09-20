import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/news_app/cubit/cubit.dart';
import 'package:oneproject/layout/news_app/cubit/states.dart';
import 'package:oneproject/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: Colors.white,
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (String? value)
                    {
                      NewsCubit.get(context).getSearch(value!);
                    },
                    validator: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'search must not be empty';
                      }
                    },
                    label: 'Search',
                    prefixIcon: Icons.search,
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
