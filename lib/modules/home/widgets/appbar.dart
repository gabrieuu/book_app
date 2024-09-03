import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      title: SizedBox(
        width: 100,
        child: Image.asset('assets/images/logo_book.png'),
      ),
      actions: [
        // Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: IconButton(
        //     onPressed: searchIconAction,
        //     icon: (searchIsSelect)
        //       ? const Icon(Icons.close)
        //       : const Icon(Icons.search)
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                Modular.to.pushNamed('/initial/chat/');
              },
              icon: Icon(Icons.chat_bubble_outline)),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
