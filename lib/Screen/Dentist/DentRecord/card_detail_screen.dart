import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardDetailScreen extends StatefulWidget {
  // final FirebaseUser user;
  // CardDetailScreen(this.user, {Key key}) : super(key: key);
  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Case Detail'),
          backgroundColor: Colors.blue[300],
        ),
        body: Slidable(
          //   key: _key,
          //   dismissal: SlidableDismissal(
          //     child: SlidableDrawerDismissal(),
          //     onWillDismiss: (actionType) {
          //       return showDialog<bool>(
          //         context: context,
          //         builder: (context) {
          //           return AlertDialog(
          //             title: Text('Delete'),
          //             content: Text('Item will be deleted'),
          //             actions: <Widget>[
          //               FlatButton(
          //                 child: Text('Cancel'),
          //                 onPressed: () => Navigator.of(context).pop(false),
          //               ),
          //               FlatButton(
          //                 child: Text('Ok'),
          //                 onPressed: () => Navigator.of(context).pop(true),
          //               ),
          //             ],
          //           );
          //         },
          //       );
          //     },
          //   ),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Front'),
              subtitle: Text('Case'),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Done',
              color: Colors.green,
              icon: Icons.check,
              // onTap: () => _showSnackBar('Saved'),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              // onTap: () => _showSnackBar('Delete'),
            ),
          ],
        ));
  }
}
