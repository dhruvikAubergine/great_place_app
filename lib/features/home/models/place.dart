import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place extends Equatable {
  const Place({
    this.id,
    this.title,
    this.image,
    this.latitude,
    this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  final String? id;
  final String? title;
  final String? image;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  Place copyWith({
    String? id,
    String? title,
    String? image,
    double? latitude,
    double? longitude,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, title, image, latitude, longitude];
}
