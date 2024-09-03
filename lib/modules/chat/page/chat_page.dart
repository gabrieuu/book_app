import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:book_app/modules/chat/controller/mensagens_controller.dart';
import 'package:book_app/modules/chat/widgets/text_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required this.chatDto});

  final ChatsViewDto chatDto;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final UserController userController = Modular.get();
  final MensagemController mensagemController = Modular.get();

  @override
  void initState() {
    super.initState();
    mensagemController.getAllMessages(widget.chatDto.userId);
  }

  @override
  void dispose() {
    mensagemController.mensagensStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chatDto.usernameDoUsuario),
          leading: const BackButton(),
          elevation: 1,
        ),
        bottomSheet: TextBar(
          sendmessage: mensagemController.sendMessage,
        ),
        body: Observer(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: mensagemController.mensagens.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final data = mensagemController.mensagens[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: (data.userId == userController.user.id)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!(data.userId == userController.user.id)) ...[
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                "https://i.postimg.cc/cCsYDjvj/user-2.png"),
                          ),
                          const SizedBox(width: 16.0 / 2),
                        ],
                        messageContaint(data, userController.user.id!, context),
                        if (data.userId == userController.user.id)
                          MessageStatusDot(status: MessageStatus.notView)
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}

Widget messageContaint(Mensagem data, String userId, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16.0 * 0.75,
      vertical: 16.0 / 2,
    ),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 0, 185, 191)
          .withOpacity((data.userId == userId) ? 1 : 0.1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      data.content,
      style: TextStyle(
        color: (data.userId == userId)
            ? Colors.white
            : Theme.of(context).textTheme.bodyLarge!.color,
      ),
    ),
  );
}

enum MessageStatus { notSent, notView, viewed }

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({super.key, this.status});
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.notSent:
          return const Color(0xFFF03738);
        case MessageStatus.notView:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return const Color(0xFF00BF6D);
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 16.0 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.notSent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
