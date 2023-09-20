import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/social_layout.dart';
import 'package:oneproject/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (context,state){
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),

                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label:Text('name'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
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
                            label:Text('email Address'),
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
                              // cubit.userRegister(
                              //   name: nameController.text,
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              //   phone: phoneController.text,
                              // );
                            }
                          },
                          obscureText: cubit.obscureText,
                          decoration:  InputDecoration(
                            border: const OutlineInputBorder(),
                            label:const Text('Password'),
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
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label:Text('phone'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        ConditionalBuilder(
                          condition: State is! SocialRegisterLoadingState,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: TextButton(
                              onPressed:(){
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              } ,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),),
                          ),
                          fallback: (BuildContext context) =>const Center(child:  CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 14,),
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
