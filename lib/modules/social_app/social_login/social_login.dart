import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../network/remote/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../social_register/register.dart';
import 'SocailCubit/cubit.dart';
import 'SocailCubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener:(context,state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uid',
                value:state.uid,
            ).then((value){
              navigateAndFinish(context, const SocialLayout());
            });
          }
        },
        builder: (context,state)
        {
          var cubit = SocialLoginCubit.get(context);
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
                              // cubit.userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
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
                          condition: State is! SocialLoginLoadingState,
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
                                navigateTo(context, SocialRegisterScreen());
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
