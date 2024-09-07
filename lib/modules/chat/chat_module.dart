import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/chat/chat_repository.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:book_app/modules/chat/controller/mensagens_controller.dart';
import 'package:book_app/modules/chat/page/chat_page.dart';
import 'package:book_app/modules/chat/page/lista_chat_page.dart';
import 'package:book_app/modules/profiile/profile_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module {
  @override
  List<Module> get imports => [AuthModule(), ProfileModule()];

  @override
  void exportedBinds(Injector i) {
    i.add(ChatRepository.new);
    i.addSingleton(ChatController.new);
    i.add(MensagemController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => ListaChatPage());
    r.child('/tela', child: (_) => ChatPage(chatDto: r.args.data));
  }
}
