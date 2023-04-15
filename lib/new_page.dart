import 'package:flutter/material.dart';

import 'responsive/desktop_body.dart';
import 'responsive/mobile_body.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/tablet_body.dart';


class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: const Text('Dashboard'),
        //backgroundColor: Colors.grey,
      //),
      body: ResponsiveLayout(
        mobileBody: MobileScaffold(),
        tabletBody: TabletScaffold(),
        desktopBody: DesktopScaffold(),
      ),
    );
  }
}