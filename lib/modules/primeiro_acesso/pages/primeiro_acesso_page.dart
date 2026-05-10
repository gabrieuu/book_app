import 'package:book_app/app_store.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class PrimeiroAcessoPage extends StatefulWidget {
  PrimeiroAcessoPage({super.key});

  @override
  State<PrimeiroAcessoPage> createState() => _PrimeiroAcessoPageState();
}

class _PrimeiroAcessoPageState extends State<PrimeiroAcessoPage> {
  late final PrimeiroAcessoController controller;

  final AppStore appStore = Modular.get<AppStore>();
  ReactionDisposer? disposer;
  @override
  void initState() {
    controller = Modular.get<PrimeiroAcessoController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Modular.to.navigate(
        '/primeiro-acesso/apresentacao',
      );
    });
    
    disposer = reaction((_) => controller.indexSelecionado, (index) {
      controller.navegaEntreAsTelas();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposer!.reaction.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            const RouterOutlet(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 10,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Observer(builder: (_) {
                            return GestureDetector(
                              onTap: () {
                                if (index == 2 &&
                                    appStore.currentUser?.username.isEmpty ==
                                        true &&
                                    appStore.currentUser?.name.isEmpty ==
                                        true) {
                                  return;
                                }
                                controller.indexSelecionado = index;
                              },
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: (controller.indexSelecionado == index)
                                      ? Colors.blue
                                      : Colors.white,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
