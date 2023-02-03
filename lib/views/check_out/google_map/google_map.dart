import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khapa_shapa/providers/check_out_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';



class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? controller;
  Location _location = Location();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 60,left: 10,bottom: 40,top: 40),
                    child: MaterialButton(
                      onPressed: () async{

                        await _location.getLocation().then((value) {
                          setState(() {
                            checkOutProvider.setLocation = value;
                          });
                          print("LOCation $value ");
                        });
                        Navigator.of(context).pop();
                      },
                      color: primaryColor,
                      child: Text("Set Location",style: TextStyle(
                        fontSize: 18
                      ),),
                      shape: StadiumBorder(),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
