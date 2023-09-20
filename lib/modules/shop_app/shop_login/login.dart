import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:oneproject/network/remote/cache_helper.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:oneproject/shared/components/constants.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../shop_register/register.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status == true)
            {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                  key: 'token',
                  value:state.loginModel.data?.token
              ).then((value){
                    token = "${state.loginModel.data?.token}";
                    navigateAndFinish(context, const ShopLayout());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                  text: "${state.loginModel.message}" ,
                  state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state)
        {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),

                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'email address must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label:Text('Email Address'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordController,

                          keyboardType: TextInputType.visiblePassword,
                          validator: ( value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password address must not be empty';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText: cubit.obscureText,
                          decoration:  InputDecoration(
                            border: const OutlineInputBorder(),
                             label:const Text('Password Address'),
                            suffixIcon: IconButton(
                                onPressed: ()
                                {
                                  cubit.changePasswordVisibility();
                                },
                                icon: Icon(cubit.suffix),
                            ),
                            prefixIcon: const Icon(Icons.lock),

                          ),
                        ),
                        const SizedBox(height: 20,),

                        ConditionalBuilder(
                          condition: State is! ShopLoginLoadingState,
                          builder: (BuildContext context) => Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: TextButton(
                                  onPressed:(){
                                    if(formKey.currentState!.validate())
                                    {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  } ,
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                  ),),),
                              ),
                          fallback: (BuildContext context) =>const Center(child:  CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text(
                              'if don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: const Text(
                                  'Register Now'
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
