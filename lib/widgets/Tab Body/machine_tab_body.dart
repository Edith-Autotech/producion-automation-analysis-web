import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/factory.dart';
import '../../models/machine.dart';

import '../../providers/database.dart';

import '../../widgets/Cards/machine_card.dart';

class MachineTabBody extends StatelessWidget {
  final FactoryModel factoryModel;
  MachineTabBody({this.factoryModel});
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Machine>>(
      stream: database.fetchMachines(factoryModel: factoryModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            List<Machine> data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 150 / 90,
                ),
                itemBuilder: (context, index) {
                  return MachineCard(
                    factory: factoryModel,
                    machine: data[index],
                  );
                },
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return null;
      },
    );
  }
}
