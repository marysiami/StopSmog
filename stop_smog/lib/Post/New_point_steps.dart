import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'API.dart';
import 'Models/Station.dart';

class NewPointSteps extends StatefulWidget {
  static const routeName = '/new_point_steps';
  @override
  createState() => _NewPointStepsState();
}

class _NewPointStepsState extends State<NewPointSteps> {
  int currentStep = 0;
  var stations = new List<Station>();
  int _value = 0;

  _getStations() {
    API.getAllStations().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stations = list.map((model) => Station.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getStations();
  }

  List<Step> _mySteps() {
    List<Step> steps = [
      Step(
          title: const Text("Wybierz miasto"),
          isActive: currentStep >= 0,
         content: Column(
//          children: <Widget>[
//            ListView.builder(
//              itemCount: stations.length,
//              itemBuilder: (context, index) {
//                return ListTile(
//                    title: Text(
//                      (stations[index].city == null
//                          ? stations[index].stationName
//                          : stations[index].city.name),
//                ));
//              },
//            ),
//          ]
          )),
      Step(
          title: const Text("Wybierz stację"),
          isActive: currentStep >= 1,
          content: Column(
            children: <Widget>[
              TextFormField(),
            ],
          )),
      Step(
          title: const Text("Wybierz pomiar"),
          isActive: currentStep >= 2,
          content: Column(
            children: <Widget>[
              TextFormField(),
            ],
          )),
    ];

    return steps;
  }

  StepperType stepperType = StepperType.vertical;
  bool complete = false;

  next() {
    this.currentStep + 1 != _mySteps().length
        ? goTo(this.currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (this.currentStep > 0) {
      goTo(this.currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => this.currentStep = step);
  }

  switchStepType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : StepperType.vertical);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Dodaj nowy punkt")),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stepper(
                steps: _mySteps(),
                type: stepperType,
                currentStep: currentStep,
                onStepCancel: cancel,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
              ),
            )
          ],
        ));
  }
}

