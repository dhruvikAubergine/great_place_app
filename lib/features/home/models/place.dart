import 'package:equatable/equatable.dart';
import 'package:great_place_app/features/home/models/place_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place extends Equatable {
  const Place({this.id, this.title, this.image, this.placeLocation});

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  final String? id;
  final String? title;
  final String? image;
  final PlaceLocation? placeLocation;

  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  Place copyWith({
    String? id,
    String? title,
    String? image,
    PlaceLocation? placeLocation,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      placeLocation: placeLocation ?? this.placeLocation,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, title, image, placeLocation];
}
