import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../textstyles/textstyle_const.dart';


class NewHomePageAddress extends StatefulWidget {
  const NewHomePageAddress({Key? key}) : super(key: key);
  @override
  _NewHomePageAddressState createState() => _NewHomePageAddressState();
}
class _NewHomePageAddressState extends State<NewHomePageAddress> {
  var lat="0.000";
  var long="0.000";
  var latt;
  var longg;

  String apiKey = "AIzaSyCYyuSkx1ANdznaNwZYE4YD2VmeLxzHy_w";

  final Completer<GoogleMapController>  _controller = Completer();
  String _draggedAddress = "";
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  _init() {
    _defaultLatLng = const LatLng(28.942477, 79.811811);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 100
    );
    _gotoUserCurrentPosition();
  }

  Uint8List? marketimages;
  final List<Marker> _markers =[];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    _init();
    _draggedAddress.toString();
  }

  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose Delivery Address',
                    style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(
                      color: const Color.fromRGBO(15, 26, 42, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(1),
                      hintText: 'Search for area/landmark',
                      prefixIcon:
                      const Icon(Icons.search, color:AppColors.primary),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          searchPlace();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 20,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Text('Search',style: TextStyle(color: AppColors.white),),
                          ),
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.primary700,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.primary700,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                    height: size.height*0.55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildBody(),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Address - $_draggedAddress",
                  style: AppTextStyles.kBody15SemiboldTextStyle,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary700),
                      onPressed: () {
                        List<String> strings = [latt.toString(),longg.toString()];
                        saveStrings(strings);
                        addAddress(_draggedAddress);
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.map_pin_ellipse),
                            const SizedBox(width: 10,),
                            Text(
                              'Pin to this Location',
                              style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                                color: AppColors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ]),
        ),
      ),
    );
  }

  addAddress(
      String map,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse("$baseurl/api/add/address/$userid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "map": map,
      }),
    );
    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
    }
    if (response.statusCode == 200) {
      Get.offAll(const DashBoardScreenMain());
    } else {
      if (kDebugMode) {
        print('address not saved');
      }
    }
  }

  Future<void> saveStrings(List<String> strings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('strings', strings);
  }
  Future _gotoUserCurrentPosition() async {

    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    final Uint8List locationIcon = await getImages('assets/img.png', 50);
    setState(() async {
      lat = currentPosition.latitude.toString();
      long = currentPosition.longitude.toString();
      var lats = double.parse(lat);
      var longs = double.parse(long);

      _markers.add(
          Marker(
              markerId: const MarkerId('0'),
              icon: BitmapDescriptor.fromBytes(locationIcon),
              position: LatLng(lats, longs),
              infoWindow: const InfoWindow(
                title: "my name",
              )
          )
      );
    });

  }
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: position,
                zoom: 15
            )
        )
    );
    await _getAddress(position);
  }
  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addresStr = "${address.street}, ${address.locality}, ${address.subLocality}, ${address
        .administrativeArea}, ${address.country}, ${address.postalCode}";
    setState(() {
      latt = position.latitude;
      longg = position.longitude;
      _draggedAddress = addresStr;
      if (kDebugMode) {
        print(latt);
      print(longg);
      print('this is latlag');
      }
    });
  }
  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      if (kDebugMode) {
        print("user don't enable location permission");
      }
    }
    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        if (kDebugMode) {
          print("user denied location permission");
        }
      }
    }

    if(locationPermission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print("user denied permission forever");
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
  Future searchPlace() async {
    String searchTerm = _searchController.text;
    List<Location> locations = await locationFromAddress(searchTerm);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      double lat = location.latitude;
      double lng = location.longitude;
      CameraPosition newPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 15.0,
      );
      _mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  Widget _buildBody() {
    return Stack(
        children : [
          _getMap(),
          _getCustomPin(),
          _getLoctionButton()
        ]
    );
  }
  Widget _getMap() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_markers),
      initialCameraPosition: _cameraPosition!,
      mapType: MapType.normal,
      onCameraIdle: () {
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (controller) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        }
        _mapController = controller;
      },
    );
  }
  Widget _getCustomPin() {
    return Positioned(
      top: MediaQuery.of(context).size.height*0.2,
      left: MediaQuery.of(context).size.width*0.4,
      child: const Icon(Icons.location_history,size: 50,color: AppColors.primary,),
    );
  }
  Widget _getLoctionButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap:  (){
          _gotoUserCurrentPosition();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
              ),]
          ),
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}