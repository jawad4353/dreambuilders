class DirectionsResponse {
  List<GeocodedWaypoint> geocodedWaypoints;
  List<Route> routes;

  DirectionsResponse({
    required this.geocodedWaypoints,
    required this.routes,
  });

  factory DirectionsResponse.fromJson(Map<String, dynamic> json) {
    var geocodedWaypointsList = json['geocoded_waypoints'] as List<dynamic>;
    List<GeocodedWaypoint> geocodedWaypoints =
    geocodedWaypointsList.map((e) => GeocodedWaypoint.fromJson(e)).toList();

    var routesList = json['routes'] as List<dynamic>;
    List<Route> routes = routesList.map((e) => Route.fromJson(e)).toList();

    return DirectionsResponse(
      geocodedWaypoints: geocodedWaypoints,
      routes: routes,
    );
  }
}

class GeocodedWaypoint {
  String geocoderStatus;
  String placeId;
  List<String> types;

  GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) {
    var typesList = json['types'] as List<dynamic>;
    List<String> types = typesList.map((e) => e.toString()).toList();

    return GeocodedWaypoint(
      geocoderStatus: json['geocoder_status'],
      placeId: json['place_id'],
      types: types,
    );
  }
}

class Route {
  Bounds bounds;
  String? copyright;
  List<Leg> legs;

  Route({
    required this.bounds,
    required this.legs,
    this.copyright,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    var boundsJson = json['bounds'] as Map<String, dynamic>;
    var legsList = json['legs'] as List<dynamic>;

    List<Leg> legs = legsList.map((e) => Leg.fromJson(e)).toList();

    return Route(
      bounds: Bounds.fromJson(boundsJson),
      legs: legs,
      copyright: json['copyrights'],
    );
  }
}

class Bounds {
  Northeast northeast;
  Southwest southwest;

  Bounds({
    required this.northeast,
    required this.southwest,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: Northeast.fromJson(json['northeast']),
      southwest: Southwest.fromJson(json['southwest']),
    );
  }
}

class Northeast {
  double lat;
  double lng;

  Northeast({
    required this.lat,
    required this.lng,
  });

  factory Northeast.fromJson(Map<String, dynamic> json) {
    return Northeast(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Southwest {
  double lat;
  double lng;

  Southwest({
    required this.lat,
    required this.lng,
  });

  factory Southwest.fromJson(Map<String, dynamic> json) {
    return Southwest(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Leg {
  Distance distance;
  Duration duration;
  String endAddress;
  LatLng endLocation;
  String startAddress;
  LatLng startLocation;
  List<Step> steps;

  Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) {
    var stepsList = json['steps'] as List<dynamic>;

    List<Step> steps = stepsList.map((e) => Step.fromJson(e)).toList();

    return Leg(
      distance: Distance.fromJson(json['distance']),
      duration: Duration.fromJson(json['duration']),
      endAddress: json['end_address'],
      endLocation: LatLng.fromJson(json['end_location']),
      startAddress: json['start_address'],
      startLocation: LatLng.fromJson(json['start_location']),
      steps: steps,
    );
  }
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'],
      value: json['value'],
    );
  }
}

class Duration {
  String text;
  int value;

  Duration({
    required this.text,
    required this.value,
  });

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      text: json['text'],
      value: json['value'],
    );
  }
}

class Step {
  Distance distance;
  Duration duration;
  String htmlInstructions;
  Polyline polyline;

  Step({
    required this.distance,
    required this.duration,
    required this.htmlInstructions,
    required this.polyline,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: Distance.fromJson(json['distance']),
      duration: Duration.fromJson(json['duration']),
      htmlInstructions: json['html_instructions'],
      polyline: Polyline.fromJson(json['polyline']),
    );
  }
}

class Polyline {
  String points;

  Polyline({
    required this.points,
  });

  factory Polyline.fromJson(Map<String, dynamic> json) {
    return Polyline(
      points: json['points'],
    );
  }
}

class LatLng {
  double lat;
  double lng;

  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
