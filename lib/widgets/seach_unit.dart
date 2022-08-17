import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myinec/screens/landing/pollingunit.dart';
import 'package:myinec/widgets/input_widget.dart';
import 'package:myinec/widgets/primary_button.dart';

class SearchUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InputWidget(
            hintText: "Polling Unit ID",
            suffixIcon: FlutterIcons.search_faw,
          ),
          SizedBox(
            height: 15.0,
          ),
          SizedBox(
            height: 25.0,
          ),
          PrimaryButton(
            text: "Find Now",
            onPressed: () {
              // Helper.nextPage(context, RequestServiceFlow());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PollingUnit()
                  ));
            },
          )
        ],
      ),
    );
  }
}
