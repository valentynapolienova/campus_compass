class Location {
   String? imgUrl;
   String? type;
   double? latitude;
   double? longitude;
   String? name;
   String? description;

   Location({this.name, this.imgUrl, this.latitude, this.longitude, this.type, this.description});
}

enum LocationType {
  UNI_BUILDING, CANTEEN, GYM, OTHER,
}