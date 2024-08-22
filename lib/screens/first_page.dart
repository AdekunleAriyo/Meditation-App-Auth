import 'package:flutter/material.dart';
import 'package:project_1_portfolio/auth/auth_service.dart';
import 'package:project_1_portfolio/constants/routes.dart';
import 'package:project_1_portfolio/dialogs/logout_dialog.dart';
import 'package:project_1_portfolio/enums/menu_action.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                )
              ];
            },
          )
        ],
      ),
      body: Center(child: Text('PAGE 1')),
    );
  }
}
