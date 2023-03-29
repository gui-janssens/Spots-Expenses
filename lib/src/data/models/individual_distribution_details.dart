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

  factory IndividualDistributionDetails.fromMap(Map<String, dynamic> map) =>
      IndividualDistributionDetails(
        map['associateId'],
        map['prolabore'],
        map['debtDeduction'],
        map['grossDistribution'],
        map['liquidDistribution'],
      );
}
