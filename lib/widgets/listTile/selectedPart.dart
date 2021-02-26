import 'package:flutter/material.dart';
import 'package:production_automation_web/models/part.dart';

class SelectedPartWidget extends StatelessWidget {
  const SelectedPartWidget(this.selectedPart, this.currentlyWorking);

  final Part selectedPart;
  final VoidCallback currentlyWorking;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Part Number",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedPart.partNumber,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Part Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedPart.partName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "No of operations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedPart.noOfOperations,
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ),
          TextButton(
            child: Text(
              "Currently Working",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: currentlyWorking,
          ),
        ],
      ),
    );
  }
}
