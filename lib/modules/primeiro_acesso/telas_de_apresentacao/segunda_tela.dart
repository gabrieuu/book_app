import 'package:book_app/modules/auth/widgets/text_field_widget.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SegundaTela extends StatelessWidget {
  SegundaTela({super.key});

  final PrimeiroAcessoController controller = Modular.get();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 92, 178, 249),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 35, bottom: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Container(
                        width: 2,
                        height: 150,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        (controller.userController.user.name.isEmpty && controller.userController.user.username.isEmpty) ? 'Para continuar,\nvamos criar um nome e um username.' : 'Ja temos seu nome e username!\n\nClique em continuar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) {
              return (controller.userController.user.name.isEmpty && controller.userController.user.username.isEmpty) 
              ? Expanded(
              flex: 2,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Qual o seu nome?',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFieldWidget(
                      validator: controller.validaName,
                      controller: controller.nome,
                      erroMessage: controller.erroNome,
                      boxColor: Colors.white,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 83, 154, 213)),
                      hintText: 'Insira seu Nome',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Qual será seu Username?',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFieldWidget(
                      validator: controller.validaUsername,
                      controller: controller.username,
                      erroMessage: controller.erroUsername,
                      boxColor: Colors.white,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 83, 154, 213)),
                      hintText: 'Insira seu Username',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
            : SizedBox();
            }),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 10),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if(controller.userController.user.name.isNotEmpty && controller.userController.user.username.isNotEmpty){
                        controller.proximoIndex();
                        return;
                      }
                      if (formKey.currentState!.validate() &&
                          controller.erroNome.isEmpty &&
                          controller.erroUsername.isEmpty) {
                        controller.alteraNomeAndUsername();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Continuar', style: TextStyle(fontSize: 20)),
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
