import 'package:flutter/material.dart';
import 'package:production_automation_web/models/factory.dart';
import 'package:production_automation_web/models/machine.dart';
import 'package:production_automation_web/screens/machine_screen.dart';

class MachineCard extends StatelessWidget {
  final Machine machine;
  final FactoryModel factory;
  MachineCard({this.machine, this.factory});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MachineScreen(
              machine: machine,
              factoryModel:factory,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  machine.machineId,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Expanded(child: Container()),
                // Text(
                //   "Current Part --> ${machine.currentPart}",
                //   softWrap: true,
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // Text(
                //   "Current operation --> ${machine.currentOperation}",
                //   softWrap: true,
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
