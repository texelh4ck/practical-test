import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practical_test/core/utils/data_state.dart';

class GeolocationState {
  final Position? position;

  GeolocationState({this.position});
}

class InitialGeolocation extends GeolocationState {}

class GeolocationDone extends GeolocationState {
  GeolocationDone({super.position});
}

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit() : super(InitialGeolocation());

  Future<DataState<Position>> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return DataFailed(Exception("Please, active the geolocation service"));
    }
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final request = await Geolocator.requestPermission();
      if (request == LocationPermission.denied) {
        return DataFailed(Exception("Please, allow the geolocation service"));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return DataFailed(
        Exception(
          "Location permissions are permanently denied, we cannot request permissions",
        ),
      );
    }

    final position = await Geolocator.getCurrentPosition();
    emit(GeolocationDone(position: position));
    return DataSuccess(position);
  }
}
