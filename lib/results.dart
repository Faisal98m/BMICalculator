import 'package:bmi_again/bmi.dart';
import 'package:bmi_again/constants.dart';
import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  const Results(
      {super.key,
      required this.bmiResult,
      required this.resultText,
      required this.interpretation});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveColor,
        title: Text('Results Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Text(
            'Your Result',
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          )),
          Expanded(
              flex: 5,
              child: ReuseableCard(
                  cardChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            resultText.toUpperCase(),
                            style: kLabelTextStyle,
                          ),
                          Text(
                            bmiResult,
                            style: kLabelTextStyle,
                          ),
                          Text(
                            interpretation,
                            style: kLabelTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                  colour: kActiveColor,
                  onPressed: () {})),
          BottomTab(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const InputPage()));
              },
              label: 'Re-calculate')
        ],
      ),
    );
  }
}
