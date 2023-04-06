import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorScreen extends StatelessWidget {

  User? user = FirebaseAuth.instance!.currentUser;

  Future<void> closeAppointment(String userEmail) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('appointments')
        .doc(user!.email.toString())
        .delete();

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.email.toString())
        .collection('appointments')
        .doc(userEmail)
        .delete();

    var doctorDoc = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.email.toString()).get();
    List<dynamic> appointmentsQueue = doctorDoc["appointmentsQueue"];
    appointmentsQueue.remove(userEmail);
    print(appointmentsQueue);
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.email.toString()).update({
      "appointmentsQueue": appointmentsQueue
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Appointments"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .doc('d@d.com')
              .collection('appointments')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data!.docs.toString());
            return ListView(
              children: snapshot.data!.docs
                  .map((a) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.blue.withOpacity(0.8),
                          child: ListTile(
                            title: Text(
                              a["name"],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            subtitle: Text(
                              a["description"],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green
                              ),
                                onPressed: () async {
                                    await closeAppointment(a["userEmail"]);
                                }, child: Text("Done")),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/default-avatar-photo-placeholder-profile-picture-default-avatar-photo-placeholder-profile-picture-eps-file-easy-to-edit-125707135.jpg"),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
            return Text(snapshot.data.toString());
          }),
    );
  }
}
