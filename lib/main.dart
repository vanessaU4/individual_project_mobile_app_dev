import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  // Conversion options
  String _selectedConversion = 'F to C';
  final TextEditingController _tempController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  // Convert temperature function
  void _convert() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0;
    double outputTemp;

    // Fahrenheit to Celsius conversion
    if (_selectedConversion == 'F to C') {
      outputTemp = (inputTemp - 32) * 5 / 9;
      _result =
          '${inputTemp.toStringAsFixed(1)} °F => ${outputTemp.toStringAsFixed(2)} °C';
    }
    // Celsius to Fahrenheit conversion
    else {
      outputTemp = inputTemp * 9 / 5 + 32;
      _result =
          '${inputTemp.toStringAsFixed(1)} °C => ${outputTemp.toStringAsFixed(2)} °F';
    }

    // Add result to history
    setState(() {
      _history.add(_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conversion type selection
            RadioListTile<String>(
              title: const Text('Fahrenheit to Celsius'),
              value: 'F to C',
              groupValue: _selectedConversion,
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Celsius to Fahrenheit'),
              value: 'C to F',
              groupValue: _selectedConversion,
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                });
              },
            ),
            // Input field for temperature
            TextField(
              controller: _tempController,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // Convert button
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            // Display the result
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Display conversion history
            Text(
              'Conversion History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
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
