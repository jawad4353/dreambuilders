import 'package:hive/hive.dart';
part 'location_adapter.g.dart';


@HiveType(typeId: 0)
class Location extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  double longitude;

  @HiveField(3)
  String time;

  Location(this.name, this.latitude, this.longitude,this.time);
}
