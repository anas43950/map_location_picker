import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_location_picker/map_location_picker.dart';

import 'key.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String address = "null";
  String autocompletePlace = "null";
  Prediction? initialValue;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PlacesAutocomplete(
            searchController: _controller,
            apiKey: API_KEY,
            mounted: mounted,
            hideBackButton: true,
            debounceDuration: const Duration(milliseconds: 500),
            onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
              if (result != null) {
                setState(() {
                  autocompletePlace = result.result.formattedAddress ?? "";
                });
              }
            },
          ),
          OutlinedButton(
            child: Text('show dialog'.toUpperCase()),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Example'),
                    content: PlacesAutocomplete(
                      apiKey: "",
                      searchHintText: "Search for a place",
                      mounted: mounted,
                      hideBackButton: true,
                      initialValue: initialValue,
                      debounceDuration: const Duration(milliseconds: 500),
                      onSelected: (value) {
                        setState(() {
                          autocompletePlace = value.structuredFormatting?.mainText ?? "";
                          initialValue = value;
                        });
                      },
                      onGetDetailsByPlaceId: (value) {
                        setState(() {
                          address = value?.result.formattedAddress ?? "";
                        });
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Done'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Google Map Location Picker\nMade By Arvind 😃 with Flutter 🚀",
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Clipboard.setData(
              const ClipboardData(text: "https://www.mohesu.com"),
            ).then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Copied to Clipboard"),
                ),
              ),
            ),
            child: const Text("https://www.mohesu.com"),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              child: const Text('Pick location'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapLocationPicker(
                        polygons: {
                          Polygon(
                            fillColor: Colors.red.shade100,
                            polygonId: const PolygonId("1"),
                            points: const [
                              LatLng(-73.9745092, 40.6093592),
                              LatLng(-73.9733183, 40.6043658),
                              LatLng(-73.9737582, 40.6016781),
                              LatLng(-73.9739084, 40.5991117),
                              LatLng(-73.972975, 40.5992176),
                              LatLng(-73.9734364, 40.5952503),
                              LatLng(-73.9710438, 40.5949977),
                              LatLng(-73.970679, 40.5926759),
                              LatLng(-73.9701748, 40.5901014),
                              LatLng(-73.9494467, 40.5924641),
                              LatLng(-73.9498329, 40.5945008),
                              LatLng(-73.9401555, 40.5955599),
                              LatLng(-73.9410138, 40.6000404),
                              LatLng(-73.9357996, 40.6006269),
                              LatLng(-73.9345765, 40.6019791),
                              LatLng(-73.9334236, 40.6027286),
                              LatLng(-73.9206268, 40.6065388),
                              LatLng(-73.9195562, 40.6071475),
                              LatLng(-73.9345336, 40.620321),
                              LatLng(-73.9454985, 40.6308581),
                              LatLng(-73.9570802, 40.6295919),
                              LatLng(-73.9656283, 40.6285922),
                              LatLng(-73.9653357, 40.6270712),
                              LatLng(-73.9705606, 40.6264763),
                              LatLng(-73.9697636, 40.6222906),
                              LatLng(-73.9733293, 40.622596),
                              LatLng(-73.9759869, 40.6196684),
                              LatLng(-73.9742088, 40.6094444),
                              LatLng(-73.9745092, 40.6093592)
                            ],
                          )
                        },
                        urlModifier: (String url) {
                          return "Hello $url";
                        },
                        apiKey: API_KEY,
                        popOnNextButtonTaped: true,
                        currentLatLng: const LatLng(-73.9401555, 40.5955599),
                        debounceDuration: const Duration(milliseconds: 500),
                        onNext: (GeocodingResult? result) {
                          if (result != null) {
                            setState(() {
                              address = result.formattedAddress ?? "";
                            });
                          }
                        },
                        onSuggestionSelected: (PlacesDetailsResponse? result) {
                          if (result != null) {
                            setState(() {
                              autocompletePlace = result.result.formattedAddress ?? "";
                            });
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          ListTile(
            title: Text("Geocoded Address: $address"),
          ),
          ListTile(
            title: Text("Autocomplete Address: $autocompletePlace"),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
