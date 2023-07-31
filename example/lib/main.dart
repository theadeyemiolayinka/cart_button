import 'package:flutter/material.dart';
import 'package:cart_button/cart_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(
        title: "Cart Button",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterInit = 0;
  int _counter = 1;
  int _counterLimit = 1;

  double _dCounter = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Normal Usage:'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartButtonInt(
                              style: CartButtonStyle.fromTheme(
                                Theme.of(context),
                                radius: Radius.zero,
                              ),
                              elevation: 7,
                              value: _counterInit,
                              onChanged: (count) {
                                setState(() {
                                  _counterInit = count;
                                });
                              },
                              defaultWidget: const Text('Default counter == 0 widget.'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartButtonDouble(
                              value: _dCounter,
                              stepper: 0.01,
                              onChanged: (count) {
                                setState(() {
                                  _dCounter = (count * 100).round() / 100;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text('Vertical:'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartButtonInt(
                              value: _counter,
                              axis: Axis.vertical,
                              onChanged: (count) {
                                setState(() {
                                  _counter = count;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartButtonInt(
                              value: _counter,
                              axis: Axis.vertical,
                              style: CartButtonTheme.of(context).copyWith(
                                activeBackgroundColor: Colors.white,
                                activeForegroundColor: Colors.blue,
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                              ),
                              onChanged: (count) {
                                setState(() {
                                  _counter = count;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartButtonDouble(
                              value: _dCounter,
                              stepper: 0.01,
                              axis: Axis.vertical,
                              onChanged: (count) {
                                setState(() {
                                  _dCounter = (count * 100).round() / 100;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('Different Sizes / Color Settings:'),
              ),
            ),
            Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 20,
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 30,
                      style: const CartButtonStyle(
                        foregroundColor: Colors.red,
                        activeForegroundColor: Colors.white,
                        activeBackgroundColor: Colors.pinkAccent,
                        buttonAspectRatio: 1.5,
                      ),
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 30,
                      style: CartButtonStyle(
                        foregroundColor: Colors.black87,
                        activeForegroundColor: Colors.black87,
                        activeBackgroundColor: Colors.white,
                        border: Border.all(color: Colors.grey),
                        elevation: 0,
                        buttonAspectRatio: 1.5,
                      ),
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 30,
                      style: CartButtonStyle(
                        foregroundColor: Colors.black87,
                        activeForegroundColor: Colors.black87,
                        activeBackgroundColor: Colors.white,
                        border: Border.all(color: Colors.grey),
                        radius: const Radius.circular(8),
                        elevation: 0,
                        buttonAspectRatio: 1.5,
                      ),
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 30,
                      numberSize: 6,
                      style: const CartButtonStyle(
                        foregroundColor: Colors.red,
                        activeForegroundColor: Colors.white,
                        activeBackgroundColor: Colors.pinkAccent,
                        radius: Radius.zero,
                      ),
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartButtonInt(
                      value: _counter,
                      size: 80,
                      onChanged: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('Minimum Limit:'),
              ),
            ),
            Center(
              child: CartButtonInt(
                value: _counterLimit,
                style: CartButtonStyle.fromTheme(
                  Theme.of(context),
                  radius: const Radius.circular(3),
                ),
                size: 30,
                onChanged: (count) {
                  if (count < 1) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Quantity cannot be less than 1.'),
                      backgroundColor: Colors.orangeAccent,
                    ));
                    return;
                  }
                  setState(() {
                    _counterLimit = count;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
