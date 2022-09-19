// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      placeLocation: json['placeLocation'] == null
          ? null
          : PlaceLocation.fromJson(
              json['placeLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'placeLocation': instance.placeLocation,
    };
