import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';

import '../../models/user.dart';

import '../../screens/landing_screens/landing_screen_factory.dart';
import '../../screens/sign_in_screen.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/landing';

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);
    final AuthBase auth = Provider.of<Auth>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserModel user = snapshot.data;
          return user != null ? FactoryLandingSCreen(user: user) : SignInScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Production Automation',
                style: theme.appBarTheme.textTheme.headline1,
              ),
            ),
            body: Card(
              child: SizedBox(
                  height: 0.95 * height,
                  child: Text(
                    "Please check your internet connection!",
                    style: theme.textTheme.headline1,
                  )),
            ),
          );
        }
        return null;
      },
    );
  }
}
