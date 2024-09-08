import 'package:book_app/core/themes.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:book_app/modules/chat/widgets/chat_tile.dart';
import 'package:book_app/modules/search/widgets/person_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListaChatPage extends StatefulWidget {
  ListaChatPage({super.key});

  @override
  State<ListaChatPage> createState() => _ListaChatPageState();
}

class _ListaChatPageState extends State<ListaChatPage> {
  final ChatController controller = Modular.get();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.chatStream.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bate Papo'),
          backgroundColor: Themes.branco,
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            Expanded(
              child: Observer(builder: (_) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: controller.chats.length,
                    itemBuilder: (_, index) {
                      return ChatTile(
                        chatDto: controller.chats[index],
                      );
                    });
              }),
            ),
          ],
        ));
  }
}
