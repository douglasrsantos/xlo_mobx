import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:xlo_mobx/repositories/table_keys.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {

  final String? id;
  final String? description;
  
  Category({
    this.id,
    this.description,
  });

  Category.fromParse(ParseObject parseObject) : 
    id = parseObject.objectId,
    description = parseObject.get(keyCategoryDescription);


  @override
  String toString() => 'Category(id: $id, description: $description)';
}
