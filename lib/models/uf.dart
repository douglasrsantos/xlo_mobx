// ignore_for_file: public_member_api_docs, sort_constructors_first
class UF {
  int? id;
  String? initials;
  String? name;
  
  UF({
    this.id,
    this.initials,
    this.name,
  });

  factory UF.fromJson(Map<String, dynamic> json) => UF(
    id: json['id'],
    initials: json['sigla'],
    name: json['nome'],
  );

  @override
  String toString() => 'UF(id: $id, initials: $initials, name: $name)';
}
