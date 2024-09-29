import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    double? inputTemp = double.tryParse(_controller.text);
    if (inputTemp != null) {
      if (_isFahrenheitToCelsius) {
        double celsius = (inputTemp - 32) * 5 / 9;
        setState(() {
          _result = "${inputTemp.toStringAsFixed(1)} °F => ${celsius.toStringAsFixed(2)} °C";
          _conversionHistory.add("F to C: ${inputTemp.toStringAsFixed(1)} => ${celsius.toStringAsFixed(2)}");
        });
      } else {
        double fahrenheit = inputTemp * 9 / 5 + 32;
        setState(() {
          _result = "${inputTemp.toStringAsFixed(1)} °C => ${fahrenheit.toStringAsFixed(2)} °F";
          _conversionHistory.add("C to F: ${inputTemp.toStringAsFixed(1)} => ${fahrenheit.toStringAsFixed(2)}");
        });
      }
    }
  }

  bool _isFahrenheitToCelsius = true; // Default conversion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFahrenheitToCelsius = true;
                    });
                  },
                  child: Text('F to C'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFahrenheitToCelsius = false;
                    });
                  },
                  child: Text('C to F'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(
              'History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
