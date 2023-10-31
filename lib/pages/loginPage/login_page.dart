import 'package:book_app/data/controller/auth_controller.dart';
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              const SizedBox(height: 20,),
              
              Obx(() => Visibility(
              visible: !controller.isLogin.value,
              child:  TextFormField(
                validator: (value) => controller.validarNome(value!),
                controller: controller.name,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),),

             

              const SizedBox(
                height: 25,
              ),

              TextFormField(
                validator: (value) => controller.validarEmail(value!),
                controller: controller.email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              TextFormField(
                validator: (value) => controller.validarSenha(value!),
                obscureText: true,
                controller: controller.password,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if(controller.formKey.currentState!.validate()){
                    if(controller.isLogin.value){
                      controller.login();
                    }else{
                      controller.createuser();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                child: Text("SignIn"),
              ),
          
              TextButton(onPressed:() {
               controller.toggleRegistrar();
              }, child: Obx(() => Text(controller.botaoCadastrar.value)))
            ],
          ),
        ),
      ),
    );
  }
}