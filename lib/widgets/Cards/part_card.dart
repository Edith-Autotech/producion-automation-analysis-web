import 'package:flutter/material.dart';
import 'package:production_automation_web/models/factory.dart';
import 'package:production_automation_web/models/part.dart';

class PartCard extends StatelessWidget {
  final Part part;
  final FactoryModel factoryModel;
  final Function handler;
  PartCard({this.part, this.factoryModel, this.handler});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextButton(
        onPressed: handler,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(part.partNumber),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(part.noOfOperations),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
