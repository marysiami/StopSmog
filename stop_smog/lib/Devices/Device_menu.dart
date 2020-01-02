import 'package:flutter/material.dart';

import '../app_localizations.dart';
import 'Device_icon.dart';
import 'Sample_devices_data.dart';



class DeviceMenuPage  extends StatelessWidget {
  static const routeName = '/deviceMenu'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,title: Text( AppLocalizations.of(context).translate('Devices'),
        style: TextStyle(
          fontFamily: "Dosis"
        ),
      ),),
      body: ListView(
      padding: const EdgeInsets.all(30),
      children: SampleDevicesData
      .map(
        (deviceData) =>DeviceIcon(
         deviceData.id,
         deviceData.title,
         deviceData.links,
         deviceData.content,
         deviceData.deviceCathegoryId,
         deviceData.imageUrl,
         deviceData.name
        ),
        ).toList(), 

    )
    );
  }
}