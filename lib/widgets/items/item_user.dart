import 'package:flutter/material.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/utilities/keyboard_utils.dart';

class ItemUser extends StatefulWidget {
  final UserModel me;
  final UserModel user;
  final VoidCallback onSelected;
  const ItemUser({Key? key, required this.me, required this.user, required this.onSelected}) : super(key: key);

  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  @override
  Widget build(BuildContext context) {

    return widget.user.id!.compareTo(widget.me.id!)==0?const SizedBox.shrink():TextButton(
      onPressed: () {
        if (KeyboardUtils.isKeyboardShowing()) {
          KeyboardUtils.closeKeyboard(context);
        }
        widget.onSelected();

      },
      child: ListTile(
        leading: widget.user.photoUrl!.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_30),
          child: Image.network(
            widget.user.photoUrl!,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            loadingBuilder: (BuildContext ctx, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                      color: Colors.grey,
                      value: loadingProgress.expectedTotalBytes !=
                          null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null),
                );
              }
            },
            errorBuilder: (context, object, stackTrace) {
              return const Icon(Icons.account_circle, size: 50);
            },
          ),
        )
            : const Icon(
          Icons.account_circle,
          size: 50,
        ),
        title: Text(
          widget.user.fullName!,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
