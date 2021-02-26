import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/factory.dart';
import '../../models/part.dart';
import '../../models/stock.dart';

import '../../providers/database.dart';

import '../../widgets/Cards/stock_card.dart';

class StockBar extends StatelessWidget {
  final FactoryModel factoryModel;
  final Part part;
  StockBar({this.factoryModel, this.part});
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Stock>>(
        stream: database.fetchStocks(model: factoryModel, part: part),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              List<Stock> data = snapshot.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: StockCard(stock: data[index]));
                  });
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else
            return Center(
              child: Text("Check connection"),
            );
          return null;
        });
  }
}
