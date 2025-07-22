import 'dart:convert';

T objectFromJson<T>(String json, T Function(Map<String, Object?> json) fromJson) {
  return fromJson(jsonDecode(json));
}

List<T> listFromJson<T>(String json, T Function(Map<String, Object?> json) fromJson) {
  final Iterable list = jsonDecode(json);
  return list.map((data) => fromJson(data)).toList();
}