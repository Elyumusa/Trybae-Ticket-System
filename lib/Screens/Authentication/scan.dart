/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/DefaultButton.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  GlobalKey key = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    List customers = [];
    num i = 860;
    while (i < 1000) {
      customers.add(
          QrImage(data: '${i + 10}', size: 150, backgroundColor: Colors.white));
    }
    print('list: ${customers.map((e) => e.data)}');

    return Scaffold(
        body: Column(
      children: [
        // buildORView(),
        //
      ],
    ));
  }

  /*buildORView() {
    return QRView(
      key: key,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
      onQRViewCreated: (controller) {
        setState(() {
          this.controller = controller;
        });
        controller.scannedDataStream.listen((barcode) {
          this.barcode = barcode;
          //TODO: Query database For a user whose id is the code scanned

          /*showModalBottomSheet(
            context: context,
            builder: (context) {
              return ConstrainedBox(
                  child: barcode == null
                      ? Text(
                          'Either its a fake Qrcode or an error occured when scanning, to verify please try scanning again')
                      : Column(
                          children: [
                            Text('User Information'),
                            Text('id:'),
                            Text('name:'),
                            Text('Already In:'),
                            Text('Phone:'),
                            Row(
                              children: [
                                DefaultButton(
                                  onPressed: () {},
                                  string: 'Submit',
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                DefaultButton(
                                  onPressed: () {},
                                  string: 'Cancel',
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                              ],
                            )
                          ],
                        ),
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.height / 2));
            },
          );*/
        });
      },
    );
  }*/
}*/

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:trybae_ticket_system/Screens/Authentication/Config/auth_services.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/new_file.dart';

import 'Config/DefaultButton.dart';

void main() {
  runApp(Scan());
}

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  Uint8List bytes = Uint8List(0);
  TextEditingController? _inputController;
  TextEditingController? _outputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return QRViewExample();
  }

  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                _qrCodeWidget(this.bytes, context),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: this._inputController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) => _generateBarCode(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.text_fields),
                          helperText:
                              'Please input your code to generage qrcode image.',
                          hintText: 'Please Input Your Code',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: this._outputController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wrap_text),
                          helperText:
                              'The barcode or qrcode you scan will be displayed in this area.',
                          hintText:
                              'The barcode or qrcode you scan will be displayed in this area.',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                        ),
                      ),
                      SizedBox(height: 20),
                      this._buttonGroup(),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scanBytes(),
          tooltip: 'Take a Photo',
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 18, color: Colors.green),
                  Text('  Generate Qrcode', style: TextStyle(fontSize: 15)),
                  Spacer(),
                  Icon(Icons.more_vert, size: 18, color: Colors.black54),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                            child: Text('Empty code ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'remove',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),
                          ),
                        ),
                        Text('|',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success =
                                  await ImageGallerySaver.saveImage(this.bytes);
                              SnackBar snackBar;
                              if (success) {
                                snackBar = new SnackBar(
                                    content:
                                        new Text('Successful Preservation!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Save failed!'));
                              }
                            },
                            child: Text(
                              'save',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.history, size: 16, color: Colors.black38),
                  Text('  Generate History',
                      style: TextStyle(fontSize: 14, color: Colors.black38)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black38),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () => _generateBarCode(this._inputController!.text),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/generate_qrcode.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Generate")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scanPhoto,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/albums.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan Photo")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode; //= await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
      DocumentSnapshot user_document = await Database()
          .parties
          .doc('SummerDance')
          .collection('Attendants')
          .doc('Elyumusa')
          .get();
      if (!user_document.exists) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Either its a fake Qrcode or an error occured when scanning, to verify please try scanning again'),
            );
          },
        );
      } else {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ConstrainedBox(
                child: /*barcode == null
                      ? Text(
                          'Either its a fake Qrcode or an error occured when scanning, to verify please try scanning again')
                      :*/
                    Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'User Information',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text('Id: ${user_document.get('ticket_id')}'),
                      Text('name: ${user_document.get('name')}'),
                      Text('Already In: ${user_document.get('Arrived')}'),
                      Text('Phone: ${user_document.get('phone')}'),
                      SizedBox(
                        height: 75,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultButton(
                            onPressed: () async {
                              if (!user_document.get('Arrived')) {
                                await Database()
                                    .parties
                                    .doc('SummerDance')
                                    .collection('Attendants')
                                    .doc('Elyumusa')
                                    .set({'Arrived': true});
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Thank you for joining us ${user_document.get('name')} enjoy the party'),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('User is already in the party'),
                                    );
                                  },
                                );
                              }
                            },
                            string: 'Submit',
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Spacer(),
                          DefaultButton(
                            onPressed: () {},
                            string: 'Cancel',
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height / 3));
          },
        );
      }
    } else {
      this._outputController!.text = barcode;
    }
  }

  Future _scanPhoto() async {
    await Permission.storage.request();
    String barcode; // = await scanner.scanPhoto();
    //this._outputController!.text = barcode;
  }

  Future _scanPath(String path) async {
    await Permission.storage.request();
    String barcode; //await scanner.scanPath(path);
    //this._outputController!.text = barcode;
  }

  Future _scanBytes() async {
    /* XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    File file = File(image!.path);
    if (file == null) return;
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._outputController!.text = barcode;*/
  }

  Future _generateBarCode(String inputCode) async {
    /* Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);*/
  }
*/
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    //onScanDone(result)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                              onScanDone(result);
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: Text('pause', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: Text('resume', style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      onScanDone(scanData);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  onScanDone(Barcode? barcode) async {
    if (barcode == null) {
      print('nothing return.');
      DocumentSnapshot user_document = await Database()
          .parties
          .doc('SummerDance')
          .collection('Attendees')
          .doc('Elyumusa') //barcode!.code
          .get();
      if (!user_document.exists) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Either its a fake Qrcode or an error occured when scanning, to verify please try scanning again'),
            );
          },
        );
      } else {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ConstrainedBox(
                child: /*barcode == null
                      ? Text(
                          'Either its a fake Qrcode or an error occured when scanning, to verify please try scanning again')
                      :*/
                    Align(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        child: Text(
                          'User Information',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: Text('Id: ${user_document.get('ticket_id')}',
                            style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: Text('Name: ${user_document.get('name')}',
                            style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already In: ', style: TextStyle(fontSize: 24)),
                          AlreadyIn(alreadyIn: user_document.get('already_in')),
                        ],
                      )),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: Text('Phone: ${user_document.get('phone')}',
                            style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(
                        height: 75,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultButton(
                            onPressed: () async {
                              if (!user_document.get('already_in')) {
                                await Database()
                                    .parties
                                    .doc('SummerDance')
                                    .collection('Attendees')
                                    .doc('Elyumusa')
                                    .update({'already_in': true});
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Thank you for joining us ${user_document.get('name')} enjoy the party'),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('User is already in the party'),
                                    );
                                  },
                                );
                              }
                            },
                            string: 'Submit',
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Spacer(),
                          DefaultButton(
                            onPressed: () {},
                            string: 'Cancel',
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height / 3));
          },
        );
      }
    } else {}
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
