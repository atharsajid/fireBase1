import 'package:firebase/Screens/HomeScreens/home.dart';
import 'package:firebase/Screens/Login/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  singin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text, password: passwordcontroller.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return showdialog(context, "Incorrect Email or Password",
            "Write your email and password correctly");
      } else if (e.code == 'wrong-password') {
        return showdialog(
            context, "Wrong Password", "Write your password correctly");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: emailTextfield(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: passTextField(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    singin();
                  },
                  child: Text("Sign In")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    });
                  },
                  child: Text("Sign Up")),
            ],
          )
        ],
      ),
    );
  }

//email textField
  TextField emailTextfield() {
    return TextField(
      controller: emailcontroller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        label: const Text("Email"),
        prefixIcon: const Icon(Icons.email),
        hintText: "Write Your Email",
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              emailcontroller.clear();
            });
          },
        ),
      ),
    );
  }

//Password TextField
  TextField passTextField() {
    return TextField(
      controller: passwordcontroller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        label: const Text("Password"),
        hintText: "Write Your Passord",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: const Icon(Icons.visibility),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  void showdialog(BuildContext context, String text1, String text2) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(text1),
          content: Text(text2),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      );
}
