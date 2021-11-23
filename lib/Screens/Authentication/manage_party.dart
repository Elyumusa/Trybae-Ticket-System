import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/palette.dart';
import 'package:trybae_ticket_system/Screens/Authentication/scan.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import '../category_picker.dart';
import 'Config/DefaultButton.dart';
import 'Config/auth_services.dart';

class ManageParty extends StatefulWidget {
  final String? partyID;

  const ManageParty({Key? key, required this.partyID}) : super(key: key);

  @override
  State<ManageParty> createState() => _ManagePartyState();
}

class _ManagePartyState extends State<ManageParty>
    with SingleTickerProviderStateMixin {
  TextEditingController? _outputController;
  TabController? controller;
  var party;
  var attendees;
  int currentTab = 0;
  Stream<QuerySnapshot>? streamAttendees;
  getParty() async {
    party = await Database().parties.doc(widget.partyID).get();
    attendees = await Database()
        .parties
        .doc(widget.partyID)
        .collection('Attendees')
        .get();
  }

  @override
  void initState() {
    // TODO: implement initState
    getParty();
    streamAttendees = Database()
        .parties
        .doc(widget.partyID)
        .collection('Attendees')
        .snapshots();
    controller = TabController(length: 3, vsync: this);
    controller!.addListener(handleTabChanges);
    print('attendees: $attendees');
    super.initState();
  }

  void handleTabChanges() {
    if (controller!.indexIsChanging) return;
    whenTabChanges(controller!.index);
    setState(() {
      currentTab = controller!.index;
    });
  }

  bool canScan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Manage Party', style: TextStyle(color: Colors.white)),
        backgroundColor: Palette.lightBlue,
        centerTitle: true,
        /*actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Close Party'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () {}, child: Text('Close Party'))
                            ],
                            content: Text(
                              'You are about to close this party, after closing it no attendees shall be accepted',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Close Party')
                      ],
                    ))
              ];
            },
          )
        ],
        */
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        bottom: TabBar(
            controller: controller,
            indicatorWeight: 4,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  child: Text(
                'All Attendees',
                style: TextStyle(
                    color: controller!.index == 0
                        ? Colors.white
                        : Colors.grey[300],
                    fontSize: 17),
              )),
              Tab(
                child: Text(
                  'Already In',
                  style: TextStyle(
                      color: controller!.index == 1
                          ? Colors.white
                          : Colors.grey[300],
                      fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Not Yet In',
                  style: TextStyle(
                      color: controller!.index == 2
                          ? Colors.white
                          : Colors.grey[300],
                      fontSize: 17),
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () async {
            canScan
                ? Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Scan()))
                : showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Everyone has already checked in, you cannot take anymore tickets'),
                      );
                    },
                  );
          },
          autofocus: true,
          child: Center(
              child: SvgPicture.network(
                  'https://www.svgrepo.com/show/334229/scan.svg',
                  width: 35,
                  height: 50,
                  color: Colors.white))),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              4,
              (index) {
                QueryDocumentSnapshot? attendee;

                return StreamBuilder<QuerySnapshot>(
                    stream: streamAttendees,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        if (!snapshot.data!.docs
                            .map((e) => attendee?.get('already_in'))
                            .contains(false)) {
                          canScan = false;
                        }
                        attendee = snapshot.data?.docs[0];
                        print('attendee: ${attendee?.get('already_in')} ');
                        return ListTile(
                            minVerticalPadding: 8,
                            horizontalTitleGap: 0,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    style: BorderStyle.none,
                                    color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            leading: Text(
                              '${attendee?.get('ticket_id')}',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            title: Text(
                              '${attendee?.get('name').toString().toUpperCase()}',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${attendee?.get('already_in').toString().toUpperCase()}',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: attendee?.get('already_in')
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                            ));
                      } else {
                        return Text('');
                      }
                    });
              },
            ),
          ],
        ),
      )),
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
              title: Text('Scanning Error'),
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

  void whenTabChanges(int index) {
    if (index == 2) {
      streamAttendees = Database()
          .parties
          .doc(widget.partyID)
          .collection('Attendees')
          .where('already_in', isEqualTo: false)
          .snapshots();
    } else if (index == 1) {
      streamAttendees = Database()
          .parties
          .doc(widget.partyID)
          .collection('Attendees')
          .where('already_in', isEqualTo: true)
          .snapshots();
    } else {
      streamAttendees = Database()
          .parties
          .doc(widget.partyID)
          .collection('Attendees')
          .snapshots();
    }
  }
}
