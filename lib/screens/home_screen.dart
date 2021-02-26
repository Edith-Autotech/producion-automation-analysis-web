import 'package:flutter/material.dart';
import 'package:production_automation_web/models/factory.dart';
import 'package:production_automation_web/models/user.dart';
import 'package:production_automation_web/providers/auth.dart';
import 'package:production_automation_web/widgets/Tab%20Body/machine_tab_body.dart';
import 'package:production_automation_web/widgets/Tab%20Body/stock_tab_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  final FactoryModel factoryModel;
  HomeScreen({@required this.user, this.factoryModel});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  void signOut() async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signOut();
    Navigator.of(context).pop();
  }

  void initState() {
    super.initState();
    print(widget.user.admin);
    if (widget.user.admin)
      _controller = TabController(length: 2, vsync: this);
    else
      _controller = TabController(length: 1, vsync: this);
    _controller.addListener(_handleController);
  }

  void _handleController() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.factoryModel.name),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            if (widget.user.admin)
              Tab(
                child: Text("Machines"),
              ),
            Tab(
              child: Text("Stock"),
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "Sign out",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: signOut,
          )
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          if (widget.user.admin)
            MachineTabBody(factoryModel: widget.factoryModel),
          StockTabBody(user: widget.user, factoryModel: widget.factoryModel),
        ],
      ),
    );
  }
}
