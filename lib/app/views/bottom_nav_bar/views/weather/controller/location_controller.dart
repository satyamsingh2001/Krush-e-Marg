import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Rx<Position?> currentLocation = Rx<Position?>(null);
  RxString currentAddress = ''.obs;
  RxString lat = ''.obs;
  RxString long = ''.obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermissions();
  }

  Future<void> requestLocationPermissions() async {
    try {
      final status = await Geolocator.requestPermission();
      if (status != LocationPermission.denied) {
        getCurrentLocation();
      } else {
        requestLocationPermissions();
        // Handle the case where permissions are denied.
        if (kDebugMode) {
          print("Location permission denied.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error requesting location permission: $e");
      }
    }
  }
  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation.value = position;

      // Get the current address from coordinates
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placeMarks.isNotEmpty) {
        Placemark address = placeMarks[0];
        // Extract city information
        String? city = address.locality; // City
        String? state = address.administrativeArea; // State
        String? country = address.country; // Country
        String? postalCode = address.postalCode;
        // print(city);// Postal Code

        // Now you have the city, state, country, and postal code
        currentAddress.value = "$city, $state, $country, $postalCode";

        lat.value = position.latitude.toString();
        long.value = position.longitude.toString();
        loading.value = !loading.value;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
    }
  }


  void updateLocation() {
    getCurrentLocation();
  }
}
