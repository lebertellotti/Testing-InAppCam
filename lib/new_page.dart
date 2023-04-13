import 'package:flutter/material.dart';

import 'responsive/desktop_body.dart';
import 'responsive/mobile_body.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/tablet_body.dart';


class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ResponsiveLayout(
        mobileBody: const MobileScaffold(),
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold(),
      ),
    );
  }
}