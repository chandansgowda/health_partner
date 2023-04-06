import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_partner/mainPage.dart';
import 'package:health_partner/screens/auth_gate.dart';
import 'package:health_partner/screens/doctorScreen.dart';


class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
      showAuthActionSwitch: true,
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              "https://i.pinimg.com/originals/30/7e/69/307e6906c251d91bb6202b3dd4736d7a.jpg",
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, signedIn) async {
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).get().then((value){
            if (value["type"]=="Patient"){
              print(value["type"]);
              Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
            }
            else{
              Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorScreen()));
            }
          });

        }),
      ],
    );
  }
}