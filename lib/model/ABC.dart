class PlanTripModel {
  String? status;
  String? message;
  Data? data;

  PlanTripModel({this.status, this.message, this.data});

  PlanTripModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Plans? plans;

  Data({this.plans});

  Data.fromJson(Map<String, dynamic> json) {
    plans = json['plans'] != null ? new Plans.fromJson(json['plans']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['plans'] = this.plans!.toJson();
    }
    return data;
  }
}

class Plans {
  RequestParameters? requestParameters;
  Plan? plan;
  Metadata? metadata;
  String? previousPageCursor;
  String? nextPageCursor;
  DebugOutput? debugOutput;
  ElevationMetadata? elevationMetadata;

  Plans(
      {this.requestParameters,
        this.plan,
        this.metadata,
        this.previousPageCursor,
        this.nextPageCursor,
        this.debugOutput,
        this.elevationMetadata});

  Plans.fromJson(Map<String, dynamic> json) {
    requestParameters = json['requestParameters'] != null
        ? new RequestParameters.fromJson(json['requestParameters'])
        : null;
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    previousPageCursor = json['previousPageCursor'];
    nextPageCursor = json['nextPageCursor'];
    debugOutput = json['debugOutput'] != null
        ? new DebugOutput.fromJson(json['debugOutput'])
        : null;
    elevationMetadata = json['elevationMetadata'] != null
        ? new ElevationMetadata.fromJson(json['elevationMetadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestParameters != null) {
      data['requestParameters'] = this.requestParameters!.toJson();
    }
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['previousPageCursor'] = this.previousPageCursor;
    data['nextPageCursor'] = this.nextPageCursor;
    if (this.debugOutput != null) {
      data['debugOutput'] = this.debugOutput!.toJson();
    }
    if (this.elevationMetadata != null) {
      data['elevationMetadata'] = this.elevationMetadata!.toJson();
    }
    return data;
  }
}

class RequestParameters {
  String? date;
  String? mode;
  String? walkSpeed;
  String? fromPlace;
  String? toPlace;
  String? time;
  String? maxWalkDistance;

  RequestParameters(
      {this.date,
        this.mode,
        this.walkSpeed,
        this.fromPlace,
        this.toPlace,
        this.time,
        this.maxWalkDistance});

  RequestParameters.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    mode = json['mode'];
    walkSpeed = json['walkSpeed'];
    fromPlace = json['fromPlace'];
    toPlace = json['toPlace'];
    time = json['time'];
    maxWalkDistance = json['maxWalkDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['mode'] = this.mode;
    data['walkSpeed'] = this.walkSpeed;
    data['fromPlace'] = this.fromPlace;
    data['toPlace'] = this.toPlace;
    data['time'] = this.time;
    data['maxWalkDistance'] = this.maxWalkDistance;
    return data;
  }
}

class Plan {
  int? date;
  From? from;
  From? to;
  List<Itineraries>? itineraries;

  Plan({this.date, this.from, this.to, this.itineraries});

  Plan.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    if (json['itineraries'] != null) {
      itineraries = <Itineraries>[];
      json['itineraries'].forEach((v) {
        itineraries!.add(new Itineraries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    if (this.itineraries != null) {
      data['itineraries'] = this.itineraries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class From {
  String? name;
  double? lon;
  double? lat;
  String? vertexType;

  From({this.name, this.lon, this.lat, this.vertexType});

  From.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lon = json['lon'];
    lat = json['lat'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['vertexType'] = this.vertexType;
    return data;
  }
}

class Itineraries {
  int? duration;
  int? startTime;
  int? endTime;
  int? walkTime;
  int? transitTime;
  int? waitingTime;
  double? walkDistance;
  bool? walkLimitExceeded;
  int? generalizedCost;
  int? elevationLost;
  int? elevationGained;
  int? transfers;
  List<Legs>? legs;
  bool? tooSloped;
  bool? arrivedAtDestinationWithRentedBicycle;

  Itineraries(
      {this.duration,
        this.startTime,
        this.endTime,
        this.walkTime,
        this.transitTime,
        this.waitingTime,
        this.walkDistance,
        this.walkLimitExceeded,
        this.generalizedCost,
        this.elevationLost,
        this.elevationGained,
        this.transfers,
        this.legs,
        this.tooSloped,
        this.arrivedAtDestinationWithRentedBicycle});

  Itineraries.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    walkTime = json['walkTime'];
    transitTime = json['transitTime'];
    waitingTime = json['waitingTime'];
    walkDistance = json['walkDistance'];
    walkLimitExceeded = json['walkLimitExceeded'];
    generalizedCost = json['generalizedCost'];
    elevationLost = json['elevationLost'];
    elevationGained = json['elevationGained'];
    transfers = json['transfers'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    tooSloped = json['tooSloped'];
    arrivedAtDestinationWithRentedBicycle =
    json['arrivedAtDestinationWithRentedBicycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['walkTime'] = this.walkTime;
    data['transitTime'] = this.transitTime;
    data['waitingTime'] = this.waitingTime;
    data['walkDistance'] = this.walkDistance;
    data['walkLimitExceeded'] = this.walkLimitExceeded;
    data['generalizedCost'] = this.generalizedCost;
    data['elevationLost'] = this.elevationLost;
    data['elevationGained'] = this.elevationGained;
    data['transfers'] = this.transfers;
    if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    data['tooSloped'] = this.tooSloped;
    data['arrivedAtDestinationWithRentedBicycle'] =
        this.arrivedAtDestinationWithRentedBicycle;
    return data;
  }
}

class Legs {
  int? startTime;
  int? endTime;
  int? departureDelay;
  int? arrivalDelay;
  bool? realTime;
  double? distance;
  int? generalizedCost;
  bool? pathway;
  String? mode;
  bool? transitLeg;
  String? route;
  int? agencyTimeZoneOffset;
  bool? interlineWithPreviousLeg;
  FromInfo? fromInfo;
  ToInfo? toInfo;
  LegGeometry? legGeometry;
  List<Steps>? steps;
  bool? rentedBike;
  bool? walkingBike;
  int? duration;

  Legs(
      {this.startTime,
        this.endTime,
        this.departureDelay,
        this.arrivalDelay,
        this.realTime,
        this.distance,
        this.generalizedCost,
        this.pathway,
        this.mode,
        this.transitLeg,
        this.route,
        this.agencyTimeZoneOffset,
        this.interlineWithPreviousLeg,
        this.fromInfo,
        this.toInfo,
        this.legGeometry,
        this.steps,
        this.rentedBike,
        this.walkingBike,
        this.duration});

  Legs.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    departureDelay = json['departureDelay'];
    arrivalDelay = json['arrivalDelay'];
    realTime = json['realTime'];
    distance = json['distance'];
    generalizedCost = json['generalizedCost'];
    pathway = json['pathway'];
    mode = json['mode'];
    transitLeg = json['transitLeg'];
    route = json['route'];
    agencyTimeZoneOffset = json['agencyTimeZoneOffset'];
    interlineWithPreviousLeg = json['interlineWithPreviousLeg'];
    fromInfo = json['from'] != null
        ? new FromInfo.fromJson(json['from'])
        : null;
    toInfo =
    json['to'] != null ? new ToInfo.fromJson(json['to']) : null;
    legGeometry = json['legGeometry'] != null
        ? new LegGeometry.fromJson(json['legGeometry'])
        : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
    rentedBike = json['rentedBike'];
    walkingBike = json['walkingBike'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['departureDelay'] = this.departureDelay;
    data['arrivalDelay'] = this.arrivalDelay;
    data['realTime'] = this.realTime;
    data['distance'] = this.distance;
    data['generalizedCost'] = this.generalizedCost;
    data['pathway'] = this.pathway;
    data['mode'] = this.mode;
    data['transitLeg'] = this.transitLeg;
    data['route'] = this.route;
    data['agencyTimeZoneOffset'] = this.agencyTimeZoneOffset;
    data['interlineWithPreviousLeg'] = this.interlineWithPreviousLeg;
    if (this.fromInfo != null) {
      data['from'] = this.fromInfo!.toJson();
    }
    if (this.toInfo != null) {
      data['to'] = this.toInfo!.toJson();
    }
    if (this.legGeometry != null) {
      data['legGeometry'] = this.legGeometry!.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['rentedBike'] = this.rentedBike;
    data['walkingBike'] = this.walkingBike;
    data['duration'] = this.duration;
    return data;
  }
}

class FromInfo {
  String? name;
  double? lon;
  double? lat;
  int? departure;
  String? vertexType;

  FromInfo({this.name, this.lon, this.lat, this.departure, this.vertexType});

  FromInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lon = json['lon'];
    lat = json['lat'];
    departure = json['departure'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['departure'] = this.departure;
    data['vertexType'] = this.vertexType;
    return data;
  }
}

class ToInfo {
  String? name;
  String? stopId;
  double? lon;
  double? lat;
  int? arrival;
  int? departure;
  String? vertexType;

  ToInfo(
      {this.name,
        this.stopId,
        this.lon,
        this.lat,
        this.arrival,
        this.departure,
        this.vertexType});

  ToInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stopId = json['stopId'];
    lon = json['lon'];
    lat = json['lat'];
    arrival = json['arrival'];
    departure = json['departure'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['stopId'] = this.stopId;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['arrival'] = this.arrival;
    data['departure'] = this.departure;
    data['vertexType'] = this.vertexType;
    return data;
  }
}

class LegGeometry {
  String? points;
  int? length;

  LegGeometry({this.points, this.length});

  LegGeometry.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['length'] = this.length;
    return data;
  }
}

class Steps {
  double? distance;
  String? relativeDirection;
  String? streetName;
  String? absoluteDirection;
  bool? stayOn;
  bool? area;
  bool? bogusName;
  double? lon;
  double? lat;
  String? elevation;
  bool? walkingBike;

  Steps(
      {this.distance,
        this.relativeDirection,
        this.streetName,
        this.absoluteDirection,
        this.stayOn,
        this.area,
        this.bogusName,
        this.lon,
        this.lat,
        this.elevation,
        this.walkingBike});

  Steps.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    relativeDirection = json['relativeDirection'];
    streetName = json['streetName'];
    absoluteDirection = json['absoluteDirection'];
    stayOn = json['stayOn'];
    area = json['area'];
    bogusName = json['bogusName'];
    lon = json['lon'];
    lat = json['lat'];
    elevation = json['elevation'];
    walkingBike = json['walkingBike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['relativeDirection'] = this.relativeDirection;
    data['streetName'] = this.streetName;
    data['absoluteDirection'] = this.absoluteDirection;
    data['stayOn'] = this.stayOn;
    data['area'] = this.area;
    data['bogusName'] = this.bogusName;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['elevation'] = this.elevation;
    data['walkingBike'] = this.walkingBike;
    return data;
  }
}

class Metadata {
  int? searchWindowUsed;
  int? nextDateTime;
  int? prevDateTime;

  Metadata({this.searchWindowUsed, this.nextDateTime, this.prevDateTime});

  Metadata.fromJson(Map<String, dynamic> json) {
    searchWindowUsed = json['searchWindowUsed'];
    nextDateTime = json['nextDateTime'];
    prevDateTime = json['prevDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchWindowUsed'] = this.searchWindowUsed;
    data['nextDateTime'] = this.nextDateTime;
    data['prevDateTime'] = this.prevDateTime;
    return data;
  }
}

class DebugOutput {
  int? precalculationTime;
  int? directStreetRouterTime;
  int? transitRouterTime;
  int? filteringTime;
  int? renderingTime;
  int? totalTime;
  TransitRouterTimes? transitRouterTimes;

  DebugOutput(
      {this.precalculationTime,
        this.directStreetRouterTime,
        this.transitRouterTime,
        this.filteringTime,
        this.renderingTime,
        this.totalTime,
        this.transitRouterTimes});

  DebugOutput.fromJson(Map<String, dynamic> json) {
    precalculationTime = json['precalculationTime'];
    directStreetRouterTime = json['directStreetRouterTime'];
    transitRouterTime = json['transitRouterTime'];
    filteringTime = json['filteringTime'];
    renderingTime = json['renderingTime'];
    totalTime = json['totalTime'];
    transitRouterTimes = json['transitRouterTimes'] != null
        ? new TransitRouterTimes.fromJson(json['transitRouterTimes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precalculationTime'] = this.precalculationTime;
    data['directStreetRouterTime'] = this.directStreetRouterTime;
    data['transitRouterTime'] = this.transitRouterTime;
    data['filteringTime'] = this.filteringTime;
    data['renderingTime'] = this.renderingTime;
    data['totalTime'] = this.totalTime;
    if (this.transitRouterTimes != null) {
      data['transitRouterTimes'] = this.transitRouterTimes!.toJson();
    }
    return data;
  }
}

class TransitRouterTimes {
  int? tripPatternFilterTime;
  int? accessEgressTime;
  int? raptorSearchTime;
  int? itineraryCreationTime;

  TransitRouterTimes(
      {this.tripPatternFilterTime,
        this.accessEgressTime,
        this.raptorSearchTime,
        this.itineraryCreationTime});

  TransitRouterTimes.fromJson(Map<String, dynamic> json) {
    tripPatternFilterTime = json['tripPatternFilterTime'];
    accessEgressTime = json['accessEgressTime'];
    raptorSearchTime = json['raptorSearchTime'];
    itineraryCreationTime = json['itineraryCreationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tripPatternFilterTime'] = this.tripPatternFilterTime;
    data['accessEgressTime'] = this.accessEgressTime;
    data['raptorSearchTime'] = this.raptorSearchTime;
    data['itineraryCreationTime'] = this.itineraryCreationTime;
    return data;
  }
}

class ElevationMetadata {
  double? ellipsoidToGeoidDifference;
  bool? geoidElevation;

  ElevationMetadata({this.ellipsoidToGeoidDifference, this.geoidElevation});

  ElevationMetadata.fromJson(Map<String, dynamic> json) {
    ellipsoidToGeoidDifference = json['ellipsoidToGeoidDifference'];
    geoidElevation = json['geoidElevation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ellipsoidToGeoidDifference'] = this.ellipsoidToGeoidDifference;
    data['geoidElevation'] = this.geoidElevation;
    return data;
  }
}
