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
}
