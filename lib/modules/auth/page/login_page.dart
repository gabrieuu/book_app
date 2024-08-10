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
      key: controller.scaffoldKeyLoginPage,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Observer(builder: (_) {
              return Flexible(
                flex: !controller.isLogin ? 2 : 1,
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
              );
            }),
            
            Observer(builder: (context) {
              return Expanded(
                flex: controller.isLogin ? 3 : 5,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Observer(
                        builder: (context) {
                          return (controller.isLogin)
                              ? SizedBox()
                              : Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
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
                                              'Nome',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        padding: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: TextFormField(
                                          validator: (value) =>
                                              controller.validarNome(value!),
                                          controller: controller.name,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          decoration: const InputDecoration(
                                            hintText: "Insira seu nome",
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      ),
                                      Observer(
                                        builder: (context) {
                                          return (controller
                                                  .erroNome.isNotEmpty)
                                              ? Text(
                                                  controller.erroNome,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                )
                                              : SizedBox();
                                        },
                                      )
                                    ],
                                  ),
                                );
                        },
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
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                validator: (value) =>
                                    controller.validarEmail(value!),
                                controller: controller.email,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: const InputDecoration(
                                  hintText: "Insira seu email",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Observer(
                              builder: (context) {
                                return (controller.erroEmail.isNotEmpty)
                                    ? Text(
                                        controller.erroEmail,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    : SizedBox();
                              },
                            )
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
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Observer(builder: (_) {
                                return TextFormField(
                                  obscureText: !controller.passwordVisibility,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  validator: (value) =>
                                      controller.validarSenha(value!),
                                  controller: controller.password,
                                  decoration: InputDecoration(
                                    hintText: "*******",
                                    hintStyle: TextStyle(
                                        color: Colors.black45,
                                        letterSpacing: 10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                            (controller.passwordVisibility)
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                );
                              }),
                            ),
                            Observer(
                              builder: (context) {
                                return (controller.erroSenha.isNotEmpty)
                                    ? Text(
                                        controller.erroSenha,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    : SizedBox();
                              },
                            )
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
                      Observer(
                        builder: (context) {
                          return (controller.loginIsLoading)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (controller.formKey.currentState!
                                            .validate() &&
                                        controller.erroEmail.isEmpty &&
                                        controller.erroSenha.isEmpty) {
                                      controller.formKey.currentState!.save();
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
                                      constraints:
                                          BoxConstraints(maxWidth: 350),
                                      child: Center(child: Text('Entrar'))),
                                );
                        },
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Novo usuario? ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                InkWell(
                                  onTap: controller.toggleRegistrar,
                                  child: Observer(builder: (_) {
                                    return Text(
                                      controller.isLogin
                                          ? 'Cadastre-se'
                                          : 'Login',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue[400],
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
            },)
          ],
        ),
      ),
    );
  }
}
