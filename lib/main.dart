import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class AppState with ChangeNotifier {
  Timer? _timer;
  int widget2Value = 0;
  int widget1Value = 0;
  int successScore = 0;
  int failureScore = 0;
  int totalAttempts = 0;
  int timerValue = 5;
  bool showSuccessMessage = false;
  bool showFailureMessage = false;

  void onTapWidget5() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tappedSecond = DateTime.now().second;

    widget2Value = Random().nextInt(60);
    widget1Value = tappedSecond;
    totalAttempts++;

    prefs.setInt('widget2Value', widget2Value);
    prefs.setInt('widget1Value', widget1Value);

    if ((widget2Value - tappedSecond).abs() <= 1 || (tappedSecond - widget2Value).abs() <= 1) {

      if (widget1Value == widget2Value) {
        successScore++;
        showSuccessMessage = true;
        showFailureMessage = false;
      } else {
        failureScore++;
        showFailureMessage = true;
        showSuccessMessage = false;
      }
    } else {
      failureScore++;
      showFailureMessage = true;
      showSuccessMessage = false;
    }

    resetTimer();
    notifyListeners();
  }

  void resetTimer() {
    timerValue = 5;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerValue > 0) {
        timerValue--;
      } else {
        failureScore++;
        showFailureMessage = true;
        showSuccessMessage = false;
        timer.cancel(); // Stop the timer
        notifyListeners();
        penalty();
      }
      notifyListeners();
    });
  }

  void penalty() {
    failureScore++;
    showFailureMessage = true;
    showSuccessMessage = false;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('KJBN LABS TASK'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue],
          ),
        ),
        child: ChangeNotifierProvider(
          create: (context) => AppState(),
          child: MyWidgetTree(),
        ),
      ),
    );
  }
}

class MyWidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    double greyColorValue = 1 - appState.timerValue / (5);
    Color progressColor = Colors.green.shade900;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange, Colors.yellow],
                  ),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Current Second", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    SizedBox(height: 8.0),
                    Divider(
                      color: Colors.black,
                      thickness: 4.0,
                    ),
                    SizedBox(height: 8.0),
                    Text("${appState.widget1Value}", textAlign: TextAlign.center),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange, Colors.yellow],
                  ),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Random Number", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    SizedBox(height: 8.0),
                    Divider(
                      color: Colors.black,
                      thickness: 4.0,
                    ),
                    SizedBox(height: 8.0),
                    Text("${appState.widget2Value}", textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 50.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
              color: appState.showSuccessMessage
                  ? Colors.green
                  : (appState.showFailureMessage
                  ? Colors.redAccent.shade200
                  : null),
            ),
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  _getMessage(appState),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: CircularProgressIndicator(
                  value: 1 - greyColorValue,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  backgroundColor: Colors.grey,
                  strokeWidth: 10.0,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(appState.timerValue ~/ 60).toString().padLeft(2, '0')}:${(appState.timerValue % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50.0),
          ElevatedButton(
            onPressed: () {
              appState.onTapWidget5();
            },
            child: Text("Click"),
          ),
        ],
      ),
    );
  }

  String _getMessage(AppState appState) {
    if (appState.showSuccessMessage) {
      return "Success! \nScore:${appState.successScore} / ${appState.totalAttempts}";
    } else if (appState.showFailureMessage) {
      if (appState.timerValue == 0) {
        return "Sorry! Timeout and one attempt is \nconsidered for failure as penalty \n ${appState.failureScore} / ${appState.totalAttempts}";
      } else {
        return "Sorry, try again! \n\nAttempts: ${appState.failureScore} / ${appState.totalAttempts}";
      }
    } else {
      return "";
    }
  }
}

