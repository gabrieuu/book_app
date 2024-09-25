import 'package:book_app/core/themes.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget(
      {super.key,
      this.searchIsSelect,
      this.backAction,
      this.focusNode,
      this.textFieldOnChanged,
      this.textFieldController,
      this.searchIconAction,
      this.hintText});

  final bool? searchIsSelect;
  final Function()? backAction;
  final FocusNode? focusNode;
  final Function(String)? textFieldOnChanged;
  final TextEditingController? textFieldController;
  final void Function()? searchIconAction;
  final String? hintText;

  final ChatController chatController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Themes.branco,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.white,
      title: SizedBox(
        width: 100,
        child: Image.asset('assets/images/logo_book.png'),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Observer(builder: (_) {
            return Badge.count(
              isLabelVisible: (chatController.mensagensNaoVisualizadas != 0),
              count: chatController.mensagensNaoVisualizadas,
              child: IconButton(
                  onPressed: () {
                    Modular.to.pushNamed('/initial/chat/');
                  },
                  icon: const Icon(Icons.chat_bubble_outline)),
            );
          }),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
