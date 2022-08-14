import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogg(String title, String subtitle, Function() fxn,
      BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.network(
                'https://www.citypng.com/public/uploads/preview/yield-caution-red-triangle-caution-road-traffic-11585779316nnaqrpebpo.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        content: Text(subtitle),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              fxn();
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  Future<void> showLogoutDialog(Function() fxn, BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.network(
                'https://www.citypng.com/public/uploads/preview/yield-caution-red-triangle-caution-road-traffic-11585779316nnaqrpebpo.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Signout'),
            ),
          ],
        ),
        content: Text('Do you really wanna Sign out?'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              fxn();
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> authErrorHandle(String subtitle, BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.network(
                'https://www.citypng.com/public/uploads/preview/yield-caution-red-triangle-caution-road-traffic-11585779316nnaqrpebpo.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Error'),
            ),
          ],
        ),
        content: Text(subtitle),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}
