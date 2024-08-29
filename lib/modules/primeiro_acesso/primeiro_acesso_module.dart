import 'package:book_app/modules/primeiro_acesso/pages/primeiro_acesso_page.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/primeira_tela.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/segunda_tela.dart';
import 'package:book_app/modules/primeiro_acesso/telas_de_apresentacao/terceira_tela.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrimeiroAcessoModule extends Module{

  @override
  void binds(Injector i) {
    i.addLazySingleton<PrimeiroAcessoController>(PrimeiroAcessoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => PrimeiroAcessoPage(), children: [
      ChildRoute('/apresentacao', child:(_) => PrimeiraTela(), transition: TransitionType.rightToLeft),
      ChildRoute('/criar-usuario', child: (_) => SegundaTela(), transition: TransitionType.rightToLeft),
      ChildRoute('/finalizacao', child:(_) => TerceiraTela(), transition: TransitionType.rightToLeft),
    ]);
  }
}