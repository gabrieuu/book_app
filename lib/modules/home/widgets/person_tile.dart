import 'package:book_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      onTap: (){
        Modular.to.pushNamed('/initial/profile/', arguments: user.id);
      },
      leading: CircleAvatar(
        minRadius: 20,
        maxRadius: 40,
        child: Text(user.name[0]),
      ),
      title: Text(user.username, style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(user.name),

    );
  }
}
