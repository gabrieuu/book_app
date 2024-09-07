import 'package:book_app/core/themes.dart';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key, required this.chatDto});

  final ChatsViewDto chatDto;
  final UserController userController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      onTap: () {
        Modular.to.pushNamed('/initial/chat/tela', arguments: chatDto);
      },
      leading: CircleAvatar(
        minRadius: 20,
        maxRadius: 40,
        child: Text(chatDto.nomeDoUsuario[0]),
      ),
      title: Text(
        chatDto.usernameDoUsuario,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(chatDto.lastMessage ?? ''),
          (chatDto.visualizado == false &&
                  chatDto.idDoUsuarioQueEnviouUltimaMsg !=
                      userController.user.id!)
              ? Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Themes.corPrincipalAppModoClaro,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                )
              : const Icon(
                  Icons.check,
                  size: 16,
                )
        ],
      ),
    );
  }
}
