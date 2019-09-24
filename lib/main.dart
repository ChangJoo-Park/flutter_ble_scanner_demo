import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ble/flutter_ble.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BLETesterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class BLETesterPage extends StatefulWidget {
  BLETesterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BLETestertate createState() => _BLETestertate();
}

class _BLETestertate extends State<BLETesterPage> {
  List<Map> items = [];
  bool isDiscoverMode = true;

  @override
  void initState() {
    items.add(
      {
        "name": "Advertise Mode",
        "route": () {
          Route route =
              MaterialPageRoute(builder: (context) => AdvertiseModePage());
          Navigator.push(context, route);
        }
      },
    );

    items.add({
      "name": "Discover Mode",
      "route": () {
        Route route =
            MaterialPageRoute(builder: (context) => DiscoverModePage());
        Navigator.push(context, route);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]["name"]),
              onTap: () => items[index]["route"](),
            );
          },
        ),
      ),
    );
  }
}

class DiscoverModePage extends StatefulWidget {
  @override
  _DiscoverModePageState createState() => _DiscoverModePageState();
}

class _DiscoverModePageState extends State<DiscoverModePage> {
  FlutterBle _ble = FlutterBle.instance;
  StreamSubscription<ScanResult> scanSubscription;
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Discover Mode")),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(_started ? Icons.star : Icons.star_border),
        onPressed: () {
          setState(() => _started = !_started);
          _handleMode(_started);
        },
      ),
    );
  }

  _handleMode(bool needStart) => needStart ? start() : stop();

  start() {
    scanSubscription = _ble.scan().listen((scanResult) {
        // do something with scan result
        print('resulted');
      });
  }
  stop() {
    scanSubscription.cancel();
  }
}

class AdvertiseModePage extends StatefulWidget {
  @override
  _AdvertiseModePageState createState() => _AdvertiseModePageState();
}

class _AdvertiseModePageState extends State<AdvertiseModePage> {
  // FlutterBle _ble = FlutterBle.instance;
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advertise Mode")),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(_started ? Icons.star : Icons.star_border),
        onPressed: () {
          setState(() => _started = !_started);
          _handleMode(_started);
        },
      ),
    );
  }

  _handleMode(bool needStart) => needStart ? start() : stop();

  start() {}
  stop() {}
}
