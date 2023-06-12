import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:nepali_utils/nepali_utils.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AutovalidateMode autoValidateMode;
  TextEditingController remarksController = TextEditingController();
  TextEditingController userLocationLatController = TextEditingController();
  TextEditingController userLocationLngController = TextEditingController();
  bool isLoading = false;
  bool isSwitched = true;
  var textValue = 'Check In';
  var type = "CHECKIN";

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Check In';
        type = "CHECKIN";
        //debugPrint(type);
      });
      //print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Check Out';
        type = "CHECKOUT";
        // debugPrint(type);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation().then((value) {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    NepaliDateTime currentNepaliTime = NepaliDateTime.now();
    var dateFormat = NepaliDateFormat('yyyy-MM-dd hh:mm');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), SizedBox(height: 20.0), Text("Getting your location , please wait...")],
        ),
      )
          : Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textValue,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blueAccent,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10.0),
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    autocorrect: false,
                    controller: remarksController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Remarks here*',
                      border: InputBorder.none,
                    ),
                    maxLines: 2,
                    minLines: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                "Date and Time",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  dateFormat.format(currentNepaliTime),
                  style: const TextStyle(fontSize: 17.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                "GPS Location",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Latitude: ${userLocationLatController.text}  Longitude: ${userLocationLngController.text}",
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: InkWell(
                onTap: () {
                  _validateInputs();
                },
                child: const CircleAvatar(
                  radius: 40, // Image radius
                  child: Icon(
                    Icons.fingerprint_outlined,
                    size: 50.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      // If all data are correct then save data to the variables
      _formKey.currentState!.save();
    } else {
      // If all data are not valid then start auto validation
      setState(() {
        autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  Future<dynamic> getUserLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    double latitude = _locationData.latitude!;
    double longitude = _locationData.longitude!;

    setState(() {
      userLocationLatController.text = _locationData.latitude.toString();
      userLocationLngController.text = _locationData.longitude.toString();

      debugPrint(userLocationLatController.text + "  " + userLocationLngController.text);
    });

    return {'lat': latitude, 'lng': longitude};
  }
}