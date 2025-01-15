import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';

class TraitModel {
  int id;
  String title;
  String icon;
  Color color;
  TraitTypeEnum type;
  bool isArchived;

  TraitModel({
    this.id = 0,
    required this.title,
    required this.icon,
    required this.color,
    required this.type,
    this.isArchived = false,
  });

  factory TraitModel.fromJson(Map<String, dynamic> json) {
    TraitTypeEnum type = TraitTypeEnum.values.firstWhere((e) => e.toString().split('.').last == json['type']);

    return TraitModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      color: Color(int.parse(json['color'].toString().replaceAll("#", ""), radix: 16)),
      type: type,
      isArchived: json['is_archived'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      // ignore: deprecated_member_use
      'color': color.value.toRadixString(16),
      'type': type.toString().split('.').last,
      'is_archived': isArchived,
    };
  }
}
