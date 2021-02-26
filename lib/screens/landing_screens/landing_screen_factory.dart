import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/factory.dart';
import '../../models/user.dart';

import '../../providers/database.dart';

import '../../screens/register_screen.dart';

import '../../widgets/Cards/factory_card.dart';
import '../../widgets/Cards/register_factory_card.dart';

class FactoryLandingSCreen extends StatefulWidget {
  final UserModel user;
  FactoryLandingSCreen({@required this.user});
  @override
  _FactoryLandingSCreenState createState() => _FactoryLandingSCreenState();
}

class _FactoryLandingSCreenState extends State<FactoryLandingSCreen> {
  UserModel _localUser;

  void initState() {
    super.initState();
    getAdminStatus();
  }

  void getAdminStatus() {
    final Database database = Provider.of(context, listen: false);
    try {
      setState(() async {
        _localUser = await database.fetchUpdatedUser(widget.user);
      });
    } catch (exception) {
      print(exception);
      setState(() {
        _localUser = widget.user.copyWith(
          admin: false,
          comapanyName: null,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Production Automation"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RegisterScreen(user: _localUser),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<FactoryModel>>(
        stream: database.fetchFactories(uid: widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              List<FactoryModel> data = snapshot.data;
              return data.length != 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 83 / 70,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: FactoryCard(
                            user: _localUser,
                            factory: data[index],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: RegisterFactoryCard(
                        user: _localUser,
                      ),
                    );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return null;
        },
      ),
    );
  }
}
