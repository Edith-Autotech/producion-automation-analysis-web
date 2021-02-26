import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/database.dart';

import '../models/count_model.dart';
import '../models/factory.dart';
import '../models/machine.dart';

import '../widgets/charts/strokes_chart.dart';

class MachineScreen extends StatefulWidget {
  final Machine machine;
  final FactoryModel factoryModel;
  MachineScreen({this.machine, this.factoryModel});

  @override
  _MachineScreenState createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Row _rowItem({String label, String value}) => Row(
        children: [
          Text(label),
          Expanded(child: Container()),
          Text(value),
        ],
      );
  @override
  Widget build(BuildContext context) {
    final Database database = Provider.of<Database>(context, listen: false);
    final String dateString = selectedDate.toString().split(" ")[0];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.machine.machineId),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<CountModel>(
            stream: database.streamCountModel(
              dateString: dateString,
              factoryModel: widget.factoryModel,
              machine: widget.machine,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  CountModel _count = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 0.3 * MediaQuery.of(context).size.width,
                          ),
                          Text(
                            "Hourly Analysis",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text("Select date"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            height: 0.6 * MediaQuery.of(context).size.height,
                            width: 0.8 * MediaQuery.of(context).size.width,
                            child: Center(
                                child: StrokesChart(
                              machine: widget.machine,
                              factoryModel: widget.factoryModel,
                              countModel: _count,
                            )),
                          ),
                          SizedBox(
                            height: 0.6 * MediaQuery.of(context).size.height,
                            width: 0.15 * MediaQuery.of(context).size.width,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _rowItem(label: "Date", value: _count.date),
                                    _rowItem(
                                        label: "Count",
                                        value: _count.count.toString()),
                                    _rowItem(
                                      label: "Idle Time",
                                      value: _count.idleTime,
                                    ),
                                    _rowItem(
                                      label: "Standby Time",
                                      value: _count.standbyTime,
                                    ),
                                    _rowItem(
                                      label: "Production Time",
                                      value: _count.productionTime,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else
                  return Center(
                    child: Text("there is no data for the selected date"),
                  );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return Center(
                  child: Text("Check internet connection"),
                );
            },
          ),
        )

        //

        );
    // );
  }
}
