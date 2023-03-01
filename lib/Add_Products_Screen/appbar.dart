import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.orange, Colors.amber])),
          child: SafeArea(
              child: Center(
            child: ListTile(
                leading: IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/'),
                    icon: Transform.scale(
                      scaleX: -1,
                      child: const Icon(
                        Icons.arrow_right_alt,
                        size: 40,
                        color: Colors.white,
                      ),
                    )),
                title: const Text(
                  'User\'s Orders',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ))),
    );
  }
}
