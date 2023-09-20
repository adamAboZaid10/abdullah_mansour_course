import 'package:flutter/material.dart';
import 'package:oneproject/shared/components/components.dart';
class LoginScreen extends StatefulWidget{
     LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
     var emailController =  TextEditingController();

     var passwordController = TextEditingController();

     var formKey = GlobalKey<FormState>();

     bool isPassword =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key:formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                     height: 30,
                   ),
                    Container(
                      child: defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                        validator: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'enter your email address';
                          }
                        },
                          label: 'email address',
                          prefixIcon: Icons.email,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          // validate: (String? value)
                          // {
                          //   if(value!.isEmpty)
                          //   {
                          //     return 'password must not be empty';
                          //   }
                          //   return null;
                          // },
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                              {
                                return 'enter your password';
                              }
                          },
                          label: 'password',
                          prefixIcon: Icons.lock,
                          suffix: isPassword? Icons.visibility :Icons.visibility_off,
                          obscure: isPassword,
                          suffixPressed: ()
                          {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          }
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: defaultButton(
                        text: 'LOGIN',
                        function: (){
                          if (formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        const Text('don\'t have an account?',),
                        TextButton(onPressed: () {},
                            child:const Text('Register Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
