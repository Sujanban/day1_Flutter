import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 10.0),
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage('http://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 2.0),
          Center(
              child: Text(
                "Gita Sharma",
                style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 5.0),
          Center(child: Text("gita@gmail.com")),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20.0,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.insert_drive_file_outlined),
              title: Text("Terms and Conditions"),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20.0,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("Location"),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20.0,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text("Contacts"),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}