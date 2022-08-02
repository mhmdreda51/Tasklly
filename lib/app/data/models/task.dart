import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const Task({
    required this.color,
    required this.icon,
    required this.title,
    this.todos,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) =>
      Task(
        icon: icon ?? this.icon,
        color: color ?? this.color,
        title: title ?? this.title,
        todos: todos ?? this.todos,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        color: json['color'],
        icon: json['icon'],
        title: json['title'],
        todos: json['todos'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'todos': todos,
        'color': color,
      };

  @override
  List<Object?> get props => [title, icon, color];
}
