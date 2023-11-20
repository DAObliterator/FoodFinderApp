import 'package:flutter/material.dart';
import 'package:testing/components/restaurant_card.dart';
import 'package:testing/utils/upper_lower_limit.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _somethingEntered = false;
  bool _anyElementDisplayed = false;
  String _dropDownValue = "";
  String _dropDownValue2 = "";
  String _foodTypeValue = "";
  String _dropDownValue4 = "";
  String _dropDownValue5 = "";
  String _dropDownValue6 = "";
  String _dropDownValue7 = "";
  String _dropDownValue8 = "";
  String _lowerLimit = "";
  String _upperLimit = "";
  bool _searchClicked = false;
  late String _enteredInput;
  int count = 0;

  List<Map<String, dynamic>> eateries = [
    {
      "eatery": "Yummpies",
      "Veg": true,
      "Name": "Veg Fried Rice",
      "price": 80,
      "type": "Fried Rice"
    },
    {
      "eatery": "Yummpies",
      "Veg": false,
      "Name": "Chicken Fried Rice",
      "price": 90,
      "type": "Fried Rice"
    },
    {
      "eatery": "BitsAndBytes",
      "Veg": false,
      "Name": "Double Chicken Noodles",
      "price": 110,
      "type": "Noodles"
    },
    {
      "eatery": "Yummpies",
      "Veg": false,
      "Name": "Egg Fried Rice",
      "price": 90,
      "type": "Fried Rice"
    },
    {
      "eatery": "BitsAndBytes",
      "Veg": true,
      "Name": "Masala Dosa",
      "price": 50,
      "type": "Dosa"
    },
    {
      "eatery": "Yummpies",
      "Veg": false,
      "Name": "Chicken Biriyani",
      "price": 100,
      "type": "Biriyani"
    },
    {
      "eatery": "Yummpies",
      "Veg": false,
      "Name": "Chicken Dum Biriyani",
      "price": 130,
      "type": "Biriyani"
    },
  ];

  List<String> fruits = ["apple", "orange", "banana"];

  // This widget is the root of your application.
  void handleVegNonVeg(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
        _searchClicked = false;
      });
      print('selectedValue - $selectedValue \n');
    }
  }

  void handlePriceRange(String? selectedValue2) {
    if (selectedValue2 is String) {
      setState(() {
        _dropDownValue2 = selectedValue2;
        _searchClicked = false;
      });
      print('selectedValue2 - $selectedValue2 \n');
    }
  }

  void handleFoodTypeChange(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _foodTypeValue = selectedValue; // the type selected is stored in this variable ie _foodTypeValue
        _searchClicked = false;
      });
      print('_foodTypeValue - $_foodTypeValue \n');
    }
  }

  void _handleSearchBtnClick() {
    if (_searchClicked == false &&
        _dropDownValue != null &&
        _dropDownValue2 != null &&
        _foodTypeValue != null ) {
      setState(() {
        _searchClicked = true;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position locationDetails = await Geolocator.getCurrentPosition();

    print("$locationDetails - locationDetails \n");

    return await Geolocator.getCurrentPosition();
  }

  bool anyElementDisplayed(List eateries) {
    for (var element in eateries) {
      if (_dropDownValue2.isNotEmpty &&
          upperLowerLimit(_dropDownValue2).elementAt(0) <= element['price'] &&
          element['price'] <= upperLowerLimit(_dropDownValue2).elementAt(1) &&
          element['Veg'] == _dropDownValue) {
        return true;
      } else if (_dropDownValue2.isNotEmpty &&
          upperLowerLimit(_dropDownValue2).elementAt(0) <= element['price'] &&
          element['price'] <= upperLowerLimit(_dropDownValue2).elementAt(1) &&
          element['Veg'] != _dropDownValue) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Find Your Food"),
          centerTitle: true,
          backgroundColor: Colors.orange[600],
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: ColoredBox(
                      color: Colors.amber,
                      child: SizedBox(
                        height: 5*height/6,
                        width: width,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: DropdownButton(
                                      hint: Text("Veg/Non-Veg"),
                                      onChanged: handleVegNonVeg,
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text("Veg"),
                                          value: "Veg",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Non Veg"),
                                          value: "Non Veg",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                          hint: Text("Price-Range"),
                                          onChanged: handlePriceRange,
                                          items: const [
                                            DropdownMenuItem(
                                              child: Text("0-30"),
                                              value: "10-30",
                                            ),
                                            DropdownMenuItem(
                                              child: Text("31-50"),
                                              value: "31-50",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('51-80'),
                                              value: "51-80",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('81-110'),
                                              value: "81-110",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('111-140'),
                                              value: "111-140",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('141-200'),
                                              value: "141-200",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: DropdownButton(
                                      hint: Text("Available Food"),
                                      onChanged: handleFoodTypeChange,
                                      items:  [
                                        DropdownMenuItem(
                                          child: Text("Dosa"),
                                          value: "Dosa",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Biriyani"),
                                          value: "Biriyani",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Fried Rice"),
                                          value: "Fried Rice",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Noodles"),
                                          value: "Noodles",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Shawarma/Roll"),
                                          value: "Shawrama/Roll",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Chat"),
                                          value: "Chat",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: _handleSearchBtnClick,
                                      child: Text("Search"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  for (var element in eateries)
                                    if (_dropDownValue2.isNotEmpty &&
                                        upperLowerLimit(_dropDownValue2)
                                            .elementAt(0) <=
                                            element['price'] &&
                                        element['price'] <=
                                            upperLowerLimit(_dropDownValue2)
                                                .elementAt(1) &&
                                        element['Veg'] == _dropDownValue &&
                                        _searchClicked == true)
                                      RestaurantCard(
                                          eatery: element["eatery"],
                                          Name: element["Name"],
                                          price: element["price"])
                                    else if (_dropDownValue2.isNotEmpty &&
                                        upperLowerLimit(_dropDownValue2)
                                            .elementAt(0) <=
                                            element['price'] &&
                                        element['price'] <=
                                            upperLowerLimit(_dropDownValue2)
                                                .elementAt(1) &&
                                        element['Veg'] != _dropDownValue &&
                                        _searchClicked == true)
                                      RestaurantCard(
                                          eatery: element["eatery"],
                                          Name: element["Name"],
                                          price: element["price"]),
                                ], //HERE
                              ),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: _determinePosition,
                              child: Text("Allow Location"),
                              style:
                              ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            ),
                          )
                        ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              )),
        ),
        drawer: Drawer(),
      ),
    );
  }
}
