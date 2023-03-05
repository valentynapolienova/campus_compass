class Location {
   String? imgUrl;
   int? id;
   String? type;
   double? latitude;
   double? longitude;
   String? name;
   String? description;

   Location({this.name, this.imgUrl, this.latitude, this.longitude, this.type, this.description, this.id,});
}

enum LocationType {
  UNI_BUILDING, CANTEEN, GYM, OTHER,
}