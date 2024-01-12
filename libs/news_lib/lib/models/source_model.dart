import 'package:equatable/equatable.dart';

class SourceModel extends Equatable {
  final String? id;
  final String name;

  const SourceModel({
    this.id,
    required this.name,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name,
      ];

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json['id'],
        name: json['name'] ?? '',
      );
}
