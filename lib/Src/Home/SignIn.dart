import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_web_login/Src/Home/Forgor/ForgotPassword.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignIn({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250,),
          Text(
            'Flutter Login With Firebase',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 50,),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          SizedBox(height: 4,),
          TextField(
            controller: passController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: Text(
              'Sign-In',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onPressed: signIn,
          ),
          SizedBox(height: 24,),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgotPassword())),
          ),
          SizedBox(height: 16,),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              text: 'Create an account?',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                )
              ]
            ),
          )
        ],
      ),
    );
  }
  Future signIn() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    }on FirebaseAuthException catch(e){
      print(e);
    }
  }
}