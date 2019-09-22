import 'package:flutter/material.dart';

import 'Device_icon.dart';
import 'Sample_devices_data.dart';



class DeviceMenuPage  extends StatelessWidget {
  static const routeName = '/deviceMenu'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blog"),),
      body: GridView(
      padding: const EdgeInsets.all(30),
      children: SampleDevicesData
      .map(
        (deviceData) =>DeviceIcon(
         deviceData.id,
         deviceData.title,
         deviceData.link,
         deviceData.content,
         deviceData.deviceCathegoryId,
         deviceData.imageUrl
        ),
        ).toList(), 
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200, //szerokość
      childAspectRatio: 3/2,
      crossAxisSpacing:20, // odstepy pomiedzy kafelkami wszerz
      mainAxisSpacing: 20, //odstępy pomiedzy kafelkami wys
      ),
    )
    );
  }
}