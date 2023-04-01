import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/model_controllers/user_model_controller.dart';
import 'package:geolocator/geolocator.dart';

class RemoteServices {
  final UserModelController _userModelController = Get.find();

  Future<List<Placemark>?> getCountryStateCityByLatLong() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .then((placeMarks) {
      _userModelController.cityController.text = placeMarks.first.locality!;
      _userModelController.countryController.text = placeMarks.first.country!;
      _userModelController.zipCodeController.text =
          placeMarks.first.postalCode!;
      return placeMarks;
    });
    return null;
  }
}
