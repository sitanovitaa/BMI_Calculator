import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: UserInput(),
  ));
}

class UserInput extends StatefulWidget {
  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  bool _isMale = true;
  double _height = 170.0;
  double _weight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ToggleButtons(
              children: [
                Icon(Icons.male),
                Icon(Icons.female),
              ],
              isSelected: [_isMale, !_isMale],
              onPressed: (index) => setState(() => _isMale = index == 0),
            ),
            SizedBox(height: 16.0),
            Text('Height (cm): ${_height.toStringAsFixed(1)}'),
            Slider(
              value: _height,
              min: 100.0,
              max: 250.0,
              onChanged: (value) => setState(() => _height = value),
            ),
            SizedBox(height: 16.0),
            Text('Weight (kg): ${_weight.toStringAsFixed(1)}'),
            Slider(
              value: _weight,
              min: 30.0,
              max: 150.0,
              onChanged: (value) => setState(() => _weight = value),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BmiResult(
                    isMale: _isMale,
                    height: _height,
                    weight: _weight,
                  ),
                ),
              ),
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final bool isMale;
  final double height;
  final double weight;

  const BmiResult({required this.isMale, required this.height, required this.weight});

  double calculateBmi() {
    return weight / ((height / 100) * (height / 100));
  }

  String getCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Slim';
    } else if (bmi < 25.0) {
      return 'Normal';
    } else {
      return 'Fat';
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBmi();
    String category = getCategory(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your BMI is: ${bmi.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Category: $category',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            // Add an icon based on the category
            getIcon(category),
          ],
        ),
      ),
    );
  }

  Widget getIcon(String category) {
    if (category == 'Slim') {
      return Icon(Icons.adjust, color: Colors.blue);
    } else if (category == 'Normal') {
      return Icon(Icons.sentiment_satisfied, color: Colors.green);
    } else {
      return Icon(Icons.warning, color: Colors.red);
    }
  }
}
