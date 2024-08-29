import 'package:flutter/material.dart';

SnackBar? getSnackBar(
  String mensagem, {
  BuildContext? context,
  int duracao = 6,
  Color corFundo = Colors.grey,
  Color corTexto = Colors.white,
  IconData? icon = Icons.info,
  EdgeInsets? padding,
  SnackBarAction? action,
}) {
  if (context != null) {
    action ??= SnackBarAction(
      label: 'Fechar',
      textColor: corTexto,
      onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    );
  }

  final snackbar = SnackBar(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10).copyWith(
      top: padding?.top,
      right: padding?.right,
      bottom: padding?.bottom,
      left: padding?.left,
    ),
    backgroundColor: corFundo,
    duration: Duration(seconds: duracao),
    action: action,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 10),
        Icon(icon, color: corTexto),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            mensagem,
            overflow: TextOverflow.visible,
            style: TextStyle(color: corTexto),
          ),
        ),
      ],
    ),
  );

  if (context == null) {
    return snackbar;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  return null;
}
