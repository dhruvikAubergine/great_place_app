// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) =>
    PlaceLocation(
      latitude: json['latitude'] as int?,
      longitude: json['longitude'] as int?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PlaceLocationToJson(PlaceLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
