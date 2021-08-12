// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Dialogs {
  static ProgressDialog _pr;



  static Future showProgressDialog({BuildContext context,String msg}) async{
    if (_pr!= null) _pr = null;


    _pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );



    _pr.style(
      padding: const EdgeInsets.all(10),
      message: msg,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(strokeWidth: 3,),
      elevation: 5.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(color: Colors.black,fontSize: 5.0,fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w600),

    );
    await _pr.show();


  }


  static Future updateProgressDialog({BuildContext context,String msg}) async{
    if (_pr!= null) _pr = null;


    _pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );



    _pr.style(
      padding: const EdgeInsets.all(10),
      message: msg,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(strokeWidth: 3,),
      elevation: 5.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(color: Colors.black,fontSize: 5.0,fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w600),

    );
    await _pr.show();


  }


static Future hideProgressDialog()async{
    if (_pr!= null && _pr.isShowing()) await _pr.hide();
}

}