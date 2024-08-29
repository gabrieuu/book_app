import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrimeiraTela extends StatelessWidget {
  PrimeiraTela({super.key});

  final PrimeiroAcessoController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/images/livros.png',scale: 1,),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 200,
                  child: Image.asset('assets/images/logo_book.png', scale: 1,)),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 92, 178, 249),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Estamos felizes em tê-lo conosco! Vamos configurar seu perfil para começar a aproveitar todas as funcionalidades.',
                          style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(left: 10, right: 15),
                         child: Container(
                           width: 2,
                           height: 100,
                           color: Colors.white,
                         ),
                       )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, right: 10),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: controller.proximoIndex,
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
        )),
      ],
    ),
    );
  }
}
