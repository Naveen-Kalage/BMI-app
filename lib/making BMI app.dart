import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'BMI APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Move controllers to class level so they don't get reset
  final TextEditingController wtcontroller = TextEditingController();
  final TextEditingController ftcontroller = TextEditingController();
  final TextEditingController incontroller = TextEditingController();

  // Make these state variables so they persist and can be updated
  String result = "";
  Color bgColor = Colors.pink.shade100;

  @override
  void dispose() {
    // Clean up controllers
    wtcontroller.dispose();
    ftcontroller.dispose();
    incontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
            color: bgColor,
            child: Center(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "BMI",
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: wtcontroller,
                      decoration: InputDecoration(
                          label: Text('Enter the weight (in kg)'),
                          prefixIcon: Icon(Icons.line_weight)
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: ftcontroller,
                      decoration: InputDecoration(
                          label: Text('Enter the height (in feet)'),
                          prefixIcon: Icon(Icons.height)
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: incontroller,
                      decoration: InputDecoration(
                          label: Text('Enter the height (in inches)'),
                          prefixIcon: Icon(Icons.height)
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 21),
                    ElevatedButton(
                        onPressed: () {
                          var wt = wtcontroller.text.toString().trim();
                          var ft = ftcontroller.text.toString().trim();
                          var inches = incontroller.text.toString().trim();

                          if (wt != "" && ft != "" && inches != "") {
                            try {
                              // Use double.parse instead of int.parse for decimal support
                              var iWt = double.parse(wt);
                              var iFt = double.parse(ft);
                              var iInches = double.parse(inches);

                              var tInches = (iFt * 12) + iInches;
                              var tCm = tInches * 2.54;
                              var tM = tCm / 100;
                              var bmi = iWt / (tM * tM);
                              var msg = "";
                              Color newBgColor;

                              // Fix the logic - each condition should have different messages
                              if (bmi > 25) {
                                msg = "You are OverWeight !!";
                                newBgColor = Colors.orange.shade100;
                              } else if (bmi < 18) {
                                msg = "You are UnderWeight !!";  // Fixed message
                                newBgColor = Colors.red.shade100;
                              } else {
                                msg = "You are Healthy !!";      // Fixed message
                                newBgColor = Colors.green.shade100;
                              }

                              setState(() {
                                result = "$msg \n Your BMI is : ${bmi.toStringAsFixed(3)}";
                                bgColor = newBgColor; // Update background color
                              });
                            } catch (e) {
                              // Handle parsing errors
                              setState(() {
                                result = "Please enter valid numbers only !!";
                              });
                            }
                          } else {
                            setState(() {
                              result = "Please fill all the required blanks !!";
                            });
                          }
                        },
                        child: Text("Calculate")
                    ),
                    SizedBox(height: 11),
                    Text(
                      result,
                      style: TextStyle(fontSize: 21, color: Colors.black54),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}