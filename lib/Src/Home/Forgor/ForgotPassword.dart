import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:firebase_web_login/Src/Const/Utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Reset Password'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Recive email to \n reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email)=>email!=null&&EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
                ),
                icon: Icon(
                  Icons.email
                ),
                label: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                onPressed: resetPassword,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>Center(child: CircularProgressIndicator(),),
    );

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim()
      );
      Utils.showSnackBar('Password reset Email sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    }on FirebaseAuthException catch(e){
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
