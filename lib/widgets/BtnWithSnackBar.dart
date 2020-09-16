import 'package:flutter/material.dart';

//extra component created, since we need scaffold snackbar
class BtnWithSnackBar extends StatelessWidget {
  BtnWithSnackBar({this.onPressed, this.loading, this.child});

  final Function onPressed;
  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: loading
          ? Center(
              child: SizedBox(
                height: 14,
                width: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : child,
      onPressed: () {
        onPressed(context);
      },
    );
  }
}
