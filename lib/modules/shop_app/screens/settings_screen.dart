import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/modules/shop_app/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/cubit/states.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:oneproject/shared/components/constants.dart';

class SettingsScreen  extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        nameController.text = "${cubit.settingsModel!.data!.name}";
        emailController.text = "${cubit.settingsModel!.data!.email}";
        phoneController.text = "${cubit.settingsModel!.data!.phone}";
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpDateDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 20,),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'name is empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20,),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'email is empty';
                        }
                        return null;
                      },
                      label: 'email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 20,),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'phone is empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: 40,),
                    TextButton(
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          cubit.getUpDateData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextButton(
                        onPressed: ()
                        {
                          singOut(context);
                        },
                        child: const Text(
                            'Log out',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
}}

