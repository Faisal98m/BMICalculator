import 'package:bmi_again/calBrain.dart';
import 'package:bmi_again/constants.dart';
import 'package:bmi_again/results.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

Color maleCardColour = kInactiveColor;
Color femaleCardColour = kInactiveColor;

void selectColor(Gender selectedGender) {
  if (selectedGender == Gender.male) {
    if (maleCardColour == kInactiveColor) {
      maleCardColour = kActiveColor;
      femaleCardColour = kInactiveColor;
    } else {
      maleCardColour = kInactiveColor;
    }
  }
  if (selectedGender == Gender.female) {
    femaleCardColour = kActiveColor;
    maleCardColour = kInactiveColor;
  } else {
    femaleCardColour = kInactiveColor;
  }
}

int height = 180;
int age = 72;
int weight = 60;

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRang,
        title: Center(
          child: const Text(
            'BMI Calculator',
            style: kLabelTextStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReuseableCard(
                    cardChild:
                        CardContent(icon: FontAwesomeIcons.mars, label: 'Male'),
                    colour: maleCardColour,
                    onPressed: () {
                      setState(() {
                        selectColor(Gender.male);
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ReuseableCard(
                      cardChild: CardContent(
                          icon: FontAwesomeIcons.venus, label: 'Female'),
                      colour: femaleCardColour,
                      onPressed: () {
                        setState(() {
                          selectColor(Gender.female);
                        });
                      }),
                )
              ],
            ),
          ),
          Expanded(
            child: ReuseableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Height',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      height.toString(),
                      style: kNumberStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelTextStyle,
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: const Color(0xff8d8e98),
                        activeTrackColor: const Color(0xffeb1555),
                        thumbColor: const Color(0xffeb12123),
                        overlayColor: const Color(0x29eb1555),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 15,
                        ),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 10),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120,
                        max: 220,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    )
                  ],
                ),
                colour: kInactiveColor,
                onPressed: () {}),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ReuseableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Age',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              age.toString(),
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onpressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onpressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        colour: kInactiveColor,
                        onPressed: () {})),
                Expanded(
                    child: ReuseableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Weight',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              weight.toString(),
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onpressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onpressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        colour: kInactiveColor,
                        onPressed: () {})),
              ],
            ),
          ),
          BottomTab(
            label: 'Calculate',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Results(
                        bmiResult: calc.calculateBMI(),
                        resultText: calc.getResult(),
                        interpretation: calc.getInterpretation())),
              );
            },
          )
        ],
      ),
    );
  }
}

class BottomTab extends StatelessWidget {
  const BottomTab({
    super.key,
    required this.onTap,
    required this.label,
  });

  final void Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            label,
            style: kLabelTextStyle,
          ),
        ),
        color: kRangBottom,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 80,
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onpressed,
  });

  final IconData icon;
  final void Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
      onPressed: onpressed,
      child: Icon(icon),
    );
  }
}

class ReuseableCard extends StatelessWidget {
  const ReuseableCard({
    super.key,
    required this.cardChild,
    required this.colour,
    required this.onPressed,
  });

  final Widget cardChild;
  final Color colour;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(15),
        child: cardChild,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: colour),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    ));
  }
}
