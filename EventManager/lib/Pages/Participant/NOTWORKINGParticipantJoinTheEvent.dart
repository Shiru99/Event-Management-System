// import 'package:EventManager/Authorisations/PostgresKonnection.dart';
// import 'package:EventManager/Authorisations/SaveUser.dart';
// import 'package:EventManager/Classes/EventInfo.dart';
// import 'package:EventManager/Classes/GuestInfo.dart';
// import 'package:EventManager/Classes/Teams.dart';
// import 'package:EventManager/Pages/Admin/AdminEventDetailsUpdate.dart';
// import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
// import 'package:EventManager/Pages/Admin/AdminRegisteredStudents.dart';
// import 'package:EventManager/Pages/Admin/AdminScorecard.dart';
// import 'package:EventManager/Pages/CommonPages/EventDetails.dart';
// import 'package:EventManager/Pages/Invigilator/InvigilatorEachEvent.dart';
// import 'package:EventManager/Pages/Participant/ParticipantEachEvents.dart';
// import 'package:EventManager/Widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:postgres/postgres.dart';

// import 'package:email_validator/email_validator.dart';

// class ParticipantJoinTheEvent extends StatefulWidget {
//   PostgresKonnection _postgresKonnection;
//   SaveUser _user;
//   String event_ID;
//   ParticipantJoinTheEvent(this._user, this._postgresKonnection, this.event_ID);

//   @override
//   _ParticipantJoinTheEventState createState() =>
//       _ParticipantJoinTheEventState();
// }

// class _ParticipantJoinTheEventState extends State<ParticipantJoinTheEvent> {
//   final _guestDetailsFormKey = GlobalKey<FormState>();

//   TextEditingController _mail1 = new TextEditingController();
//   TextEditingController _mail2 = new TextEditingController();

//   TextEditingController _mail3 = new TextEditingController();
//   TextEditingController _mail4 = new TextEditingController();
//   TextEditingController _password = new TextEditingController();

//   List<TextEditingController> _mailsID = [];

//   var results;
//   bool _isLoading = true;
//   int members = 0;

//   Future fun() async {
//     _mailsID.add(_mail1);
//     _mailsID.add(_mail2);
//     _mailsID.add(_mail3);
//     _mailsID.add(_mail4);

//     var event_ID = widget.event_ID;

//     PostgreSQLConnection _konnection =
//         await widget._postgresKonnection.getKonnection();

//     results = await _konnection.query(
//         'select participant_limit from evento where event_id = \'$event_ID\'');

//     members = results[0][0];

//     for (int i = 0; i < members; i++) {
//       print(i);
//       print(_mailsID[0]);
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   joinEvent() async {

//     if (_guestDetailsFormKey.currentState.validate()) {
//       print("validated");

//       for (int i = 0; i < members; i++) {
//       print(i);
//       print(_mailsID[0].text);
//     }

//       // setState(() {
//       //   _isLoading = true;
//       // });

//       // PostgreSQLConnection _konnection =
//       //     await widget._postgresKonnection.getKonnection();

//       // try {
//       //   await _konnection.transaction((ctx) async {
//           // print(guest_ID);

//           // INSERT INTO group_participant VALUES ('2020230004','20202301',0,'2020230101','The Gang','NA');

//           // await ctx.query('''
//           // INSERT INTO group_participant VALUES (@a,@b',0,@c,@d,'NA')
//           //   ''', substitutionValues: {
//             // "a": guest_ID,
//             // "b": _guestName.text,
//             // // "c": _guestDescription.text,
//             // "d": _guestPhoneNum.text,
//             // "e": _guestEmail.text,
//       //     });
//       //   });
//       // } catch (e) {
//       //   print(e.toString());
//       //   toastMessage(e.toString());
//       // }

//       // toastMessage("Updated successfully");
//       // await Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //         builder: (context) => ParticipantEachEvents(
//       //             widget._user, widget._postgresKonnection, widget.event_ID)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       fun();
//     }

//     var _teamList;
//     return Scaffold(
//       appBar: _isLoading ? null : appBarMain(context),
//       resizeToAvoidBottomPadding: false,
//       resizeToAvoidBottomInset: true,
//       body: _isLoading
//           ? loading()
//           : SingleChildScrollView(
//               child: Container(
//                 child: Center(
//                   child: Column(
//                     children: <Widget>[
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 150.0),
//                             child: logo(90, 280),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 8.0, bottom: 50.0),
//                             child: Text(
//                               " A Paradigm  Shift  💫", // 💫🌠
//                               style: TextStyle(
//                                   fontSize: 30.0,
//                                   color: Colors.white,
//                                   fontFamily: "Signatra"),
//                             ),
//                           ),
//                           Form(
//                             key: _guestDetailsFormKey,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 70.0, vertical: 5.0),
//                                   child: new TextFormField(
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                       decoration: new InputDecoration(
//                                         labelText: "Group Name",
//                                         hintText: "Group Name",
//                                       ),
//                                       textInputAction: TextInputAction.done,
//                                       controller: _password,
//                                       onFieldSubmitted: (_) =>
//                                           FocusScope.of(context).unfocus(),
//                                       validator: (password) {
                                        
//                                         if (password.isEmpty) {
//                                           return 'Please enter some text';
//                                         } else
//                                           return null;
//                                       },
//                                       onSaved: (value) {
//                                         return _password.text = value;
//                                       }),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 24.0, vertical: 10.0),
//                                   child: Container(
//                                     color: Colors.black,
//                                     child: new ListView.builder(
//                                       padding: EdgeInsets.all(8.0),
//                                       physics: const ClampingScrollPhysics(),
//                                       scrollDirection: Axis.vertical,
//                                       shrinkWrap: true,
//                                       itemCount: members,
//                                       itemBuilder: (_, index) {
//                                         return AdminRegisteredTeamPostUI(
//                                           context,
//                                           widget._user,
//                                           widget._postgresKonnection,
//                                           _mailsID,
//                                           index
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 14.0,
//                           ),

//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 75),
//                             child: new SizedBox(
//                               // width: MediaQuery.of(context).size.width,
//                               width: 280.0,
//                               height: 45.0,
//                               child: RaisedButton(
//                                 onPressed: () {
//                                   joinEvent();
//                                 },
//                                 textColor: Colors.white,
//                                 color: Colors.blueAccent,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(50.0))),
//                                 elevation: 15,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10.0),
//                                   child: new Text(
//                                     "Join",
//                                     style: new TextStyle(
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // ],
//                             ),
//                           ),

//                           SizedBox(
//                             height: 64.0,
//                           ),

//                           ///
//                           ///
//                           ///
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

// Widget AdminRegisteredTeamPostUI(BuildContext context, SaveUser _user,
//     PostgresKonnection _postgresKonnection, List<TextEditingController> _guestEmail,int index) {
//   final _signInFormKey = GlobalKey<FormState>();

//   // TextEditingController _guestEmail = new TextEditingController();
//   Future<bool> noRegistration(_guestEmail) async {
//     PostgreSQLConnection _konnection =
//         await _postgresKonnection.getKonnection();

//     var result =
//         await _konnection.query('select participant_email from participant');

//     for (var resu in result) {
//       if (resu[0] == _guestEmail) {
//         return false;
//       }
//     }
//     return true;
//   }

//   return new Card(
//     elevation: 20.0,
//     clipBehavior: Clip.antiAlias,
//     margin: EdgeInsets.all(15.0),
//     color: Colors.red,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(40.0),
//       side: BorderSide(
//         color: Colors.black,
//         width: 1.0,
//       ),
//     ),
//     child: new Container(
//       color: Colors.white,
//       padding: new EdgeInsets.all(25.0),
//       child: new Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
//             child: new TextFormField(
//                 // cursorColor: ,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//                 decoration: new InputDecoration(
//                   labelText: "Email",
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                   ),
//                   hintText: "john.doe@gmail.com",
//                   hintStyle: TextStyle(),
//                   fillColor: Colors.black,

//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                   //
//                 ),
//                 textInputAction: TextInputAction.done,
//                 controller: _guestEmail[index],
//                 validator: (_guestEmail) {
//                   if (_guestEmail.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return EmailValidator.validate(_guestEmail)
//                       ? null
//                       : "Invalid email address";
//                 },
//                 onSaved: (value) {
//                   return _guestEmail[index].text = value;
//                 }),
//           ),
//         ],
//       ),
//     ),
//   );
// }
