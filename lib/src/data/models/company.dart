import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Company {
  final String id;
  final String name;
  final String cnpj;
  final List<Item> items;
  final num grossIndividualDistribution;
  final List<Distribution> distributions;

  Company(
    this.id,
    this.name,
    this.cnpj,
    this.items,
    this.grossIndividualDistribution,
    this.distributions,
  );

  factory Company.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();

    return Company(
      document.id,
      map['name'],
      map['cnpj'],
      List<Item>.from(map['items'].map((i) => Item.fromMap(i)).toList()),
      map['grossIndividualDistribution'],
      List<Distribution>.from(
          map['distributions'].map((d) => Distribution.fromMap(d)).toList()),
    );
  }

  Map<Object, Object?> toMap() {
    return {
      'name': name,
      'cnpj': cnpj,
      'items': items.map((i) => i.toMap()),
      'grossIndividualDistribution': grossIndividualDistribution,
      'distributions': distributions.map((d) => d.toMap()),
    };
  }
}
