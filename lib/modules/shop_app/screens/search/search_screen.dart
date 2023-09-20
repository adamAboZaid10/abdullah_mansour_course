import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/modules/shop_app/screens/search/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/screens/search/cubit/states.dart';
import 'package:oneproject/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit() ,
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'enter your search';
                            }
                            return null;
                          },
                        onSubmit: (String? text)
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.shopSearch(text!);
                          }

                        },
                          label: 'Search',
                          prefixIcon: Icons.search,
                      ),
                      const SizedBox(height: 10,),
                      if(state is SearchLoadingStates)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 10,),
                      if(state is SearchSuccessStates)
                        ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder:(context ,index) => buildPruductItem(cubit.model?.data!.data?[index],context,isOldPrice: false),
                        separatorBuilder: (context ,index) => Container(
                          width: double.infinity,
                          color: Colors.blueGrey,
                          height: 1,
                        ),
                        itemCount:cubit.model!.data!.data!.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
