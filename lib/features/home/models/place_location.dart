import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_location.g.dart';

@JsonSerializable()
class PlaceLocation extends Equatable {
  const PlaceLocation({this.latitude, this.longitude, this.address});

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return _$PlaceLocationFromJson(json);
  }
  final int? latitude;
  final int? longitude;
  final String? address;

  Map<String, dynamic> toJson() => _$PlaceLocationToJson(this);

  PlaceLocation copyWith({
    int? latitude,
    int? longitude,
    String? address,
  }) {
    return PlaceLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [latitude, longitude, address];
}
