import 'package:cloud_firestore/cloud_firestore.dart';

class IndividualDistributionDetails {
  final String associateId;
  final num prolabore;
  final num debtDeduction;
  final num grossDistribution;
  final num liquidDistribution;

  IndividualDistributionDetails(
    this.associateId,
    this.prolabore,
    this.debtDeduction,
    this.grossDistribution,
    this.liquidDistribution,
  );

  factory IndividualDistributionDetails.fromDocument(
      DocumentSnapshot document) {
    dynamic map = document.data();
    return IndividualDistributionDetails(
      map['associateId'],
      map['prolabore'],
      map['debtDeduction'],
      map['grossDistribution'],
      map['liquidDistribution'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'associateId': associateId,
      'prolabore': prolabore,
      'debtDeduction': debtDeduction,
      'grossDistribution': grossDistribution,
      'liquidDistribution': liquidDistribution,
    };
  }
}
