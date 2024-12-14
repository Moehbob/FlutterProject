import 'package:flutter/material.dart';

void main() => runApp(PayrollApp());

class PayrollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: PayrollCalculator(),
    );
  }
}

class PayrollCalculator extends StatefulWidget {
  @override
  _PayrollCalculatorState createState() => _PayrollCalculatorState();
}

class _PayrollCalculatorState extends State<PayrollCalculator> {
  final TextEditingController _baseSalaryController = TextEditingController();
  final TextEditingController _overtimeHoursController = TextEditingController();
  final TextEditingController _overtimeRateController = TextEditingController();
  final TextEditingController _deductionsController = TextEditingController();

  double _netSalary = 0.0;

  void _calculateSalary() {
    final baseSalary = double.tryParse(_baseSalaryController.text) ?? 0.0;
    final overtimeHours = double.tryParse(_overtimeHoursController.text) ?? 0.0;
    final overtimeRate = double.tryParse(_overtimeRateController.text) ?? 0.0;
    final deductions = double.tryParse(_deductionsController.text) ?? 0.0;

    final grossSalary = baseSalary + (overtimeHours * overtimeRate);
    final netSalary = grossSalary - deductions;

    setState(() {
      _netSalary = netSalary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll Calculator'),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 28),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Mytextfield(controler: _baseSalaryController,decoration: 'Base Salary'),
            Mytextfield(controler: _overtimeHoursController,decoration: 'Overtime Hours'),
            Mytextfield(controler:_overtimeRateController,decoration:'Overtime Rate'),
            Mytextfield(controler: _deductionsController,decoration:'Tax'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSalary,
              child: Text('Calculate Net Salary'),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 180,
                color: Colors.blue,
                child: Text(
                  'Net Salary: $_netSalary ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mytextfield extends StatelessWidget {
   final controler;
   final decoration;
  const Mytextfield({
    super.key,

   this.controler, this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controler,
      decoration: InputDecoration(labelText: this.decoration ),
      keyboardType: TextInputType.number,
    );
  }
}
