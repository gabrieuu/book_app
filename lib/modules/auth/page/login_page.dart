import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Modular.get<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    if (controller.userIsAuthenticate) {
      Modular.to.navigate('/initial');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.asset(
                    'assets/images/logo_book.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                validator: (value) => controller.validarEmail(value!),
                                controller: controller.email,
                                decoration: const InputDecoration(
                                  hintText: "Insira seu email",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Observer(builder: (context) {
                              return (controller.erroEmail.isNotEmpty)
                                  ? Text(
                                      controller.erroEmail,
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    )
                                  : SizedBox();
                            },)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Senha',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Observer(builder: (_) {
                                return TextFormField(
                                  obscureText: !controller.passwordVisibility,
                                  validator: (value) =>
                                      controller.validarSenha(value!),
                                  controller: controller.password,
                                  decoration: InputDecoration(
                                    hintText: "*******",
                                    labelStyle: TextStyle(letterSpacing: 10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                            (controller.passwordVisibility)
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                    hintStyle: TextStyle(color: Colors.black45),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                );
                              }),
                            ),
                            Observer(builder: (context) {
                              return (controller.erroSenha.isNotEmpty)
                                  ? Text(
                                      controller.erroSenha,
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    )
                                  : SizedBox();
                            },)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Observer(builder: (context) {
                       return (controller.loginIsLoading)
                        ? Center(
                          child: CircularProgressIndicator(),
                        ) : ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate() && controller.erroEmail.isEmpty && controller.erroSenha.isEmpty) {
                            if (controller.isLogin) {
                              await controller.login();
                            } else {
                              await controller.createuser();
                            }
                            
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Container(
                            height: 60,
                            width: double.infinity,
                            constraints: BoxConstraints(maxWidth: 350),
                            child: Center(child: Text('Entrar'))),
                      );
                      },)
                    ],
                  ),
                )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Novo usuario? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Cadastre-se',
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Form(
//           key: controller.formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Login"),
//               const SizedBox(height: 20,),
              
//               Observer(builder: (_) {
//                  return Visibility(
//               visible: !controller.isLogin,
//               child:  TextFormField(
//                 validator: (value) => controller.validarNome(value!),
//                 controller: controller.name,
//                 decoration: const InputDecoration(
//                   labelText: "Name",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             );
//               },
//               ),

             

//               const SizedBox(
//                 height: 25,
//               ),

//               TextFormField(
//                 validator: (value) => controller.validarEmail(value!),
//                 controller: controller.email,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(
//                 height: 25,
//               ),

//               TextFormField(
//                 validator: (value) => controller.validarSenha(value!),
//                 obscureText: true,
//                 controller: controller.password,
//                 decoration: const InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(
//                 height: 25,
//               ),
//               ElevatedButton(
//                 onPressed: () async{
//                   if(controller.formKey.currentState!.validate()){
//                     if(controller.isLogin){
//                       await controller.login();
//                     }else{
//                       await controller.createuser();
//                     }
//                     Modular.to.navigate('/initial');
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                     fixedSize: const Size.fromWidth(200),
//                     padding: const EdgeInsets.symmetric(vertical: 20)),
//                 child: Text("SignIn"),
//               ),
          
//               TextButton(onPressed:() {
//                controller.toggleRegistrar();
//               }, child: Observer(builder: (_) {
//                  return Text(controller.botaoCadastrar);
//               },
//               ))
//             ],
//           ),
//         ),
//       ),
//     );