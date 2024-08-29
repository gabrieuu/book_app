import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TerceiraTela extends StatelessWidget {
  TerceiraTela({super.key});

  final PrimeiroAcessoController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Flexible(flex: 5,child: Image.asset('assets/images/estante.png')),
               Flexible(
                 child: RichText(
                  text: TextSpan(
                  text: 'Bem vindo ao ',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  children: [
                    TextSpan(
                      text: 'Librook',
                      
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '!',
                    ),
                  ],
                 )),
               ),
            ],
          )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(child: SizedBox(
                        width: 300,
                        child: Text('A leitura de um bom livro nos proporciona viajar e conhecer o outro lado do mundo.\n(Merari Tavares)', style: TextStyle(fontSize: 20), textAlign: TextAlign.end,))),
                      Padding(
                           padding: const EdgeInsets.only(left: 15, right: 10),
                           child: Container(
                             width: 2,
                             height: 100,
                             color: Colors.blue,
                           ),
                         ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, right: 10),
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: controller.completaIntroducao,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child:
                                Text('Continuar', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                    )
            ],
          )),
        ],
      ),
    );
  }
}