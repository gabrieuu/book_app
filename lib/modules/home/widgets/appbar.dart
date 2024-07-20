import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppBarWidget extends StatelessWidget implements	 PreferredSizeWidget {
  const AppBarWidget(
      {super.key,
      required this.searchIsSelect,
      this.backAction,
      this.focusNode,
      required this.textFieldOnChanged,
      required this.textFieldController,
      this.searchIconAction});

  final bool searchIsSelect;
  final Function()? backAction;
  final FocusNode? focusNode;
  final Function(String) textFieldOnChanged;
  final TextEditingController textFieldController;
  final void Function()? searchIconAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
    leading:(searchIsSelect)
      ? IconButton(
          onPressed: backAction,
          icon: const Icon(Icons.arrow_back),
        )
      : null,
    forceMaterialTransparency: true,
    automaticallyImplyLeading: false,
    title: (searchIsSelect)
      ? Expanded(
          child: SizedBox(
          height: 50,
          child: TextField(
            focusNode: focusNode,
            onChanged: textFieldOnChanged,
            autofocus: true,
            controller: textFieldController,
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusColor: Colors.grey,
                // border: OutlineInputBorder(
                //     borderSide: Border;})Side(color: Colors.grey),
                //     borderRadius:
                //         BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.only(top: 10, left: 10),
                hintStyle: TextStyle(fontSize: 15),
                hintText: 'Busque um Livro'),
          ),
        ))
      : SizedBox(
          width: 100,
          child: Image.asset('assets/images/logo_book.png'),
        ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: searchIconAction,
          icon: (searchIsSelect)
            ? const Icon(Icons.close)
            : const Icon(Icons.search)
        ),
      ),
    ],
        );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
