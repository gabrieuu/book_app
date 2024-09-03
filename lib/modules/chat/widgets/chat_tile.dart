import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chatDto});

  final ChatsViewDto chatDto;

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
          Icon(
            Icons.check,
            size: 16,
          )
        ],
      ),
    );
  }
}
