import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Distribution {
  final String id;
  final DateTime dateTime;
  final num totalDistributed;
  final List<IndividualDistributionDetails> individualDistributionDetails;

  Distribution(this.id, this.dateTime, this.totalDistributed,
      this.individualDistributionDetails);

  factory Distribution.fromDocument(DocumentSnapshot document) {
    dynamic map = document.data();
    return Distribution.fromMap(map);
  }

  factory Distribution.fromMap(Map<String, dynamic> map) => Distribution(
        map['document.id'],
        DateTime.parse(map['dateTime']),
        map['totalDistributed'],
        List<IndividualDistributionDetails>.from(
          map['individualDistributionDetails']
              .map((i) => IndividualDistributionDetails.fromDocument(i))
              .toList(),
        ),
      );

  Map<Object, Object?> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'totalDistributed': totalDistributed,
      'individualDistributionDetails':
          individualDistributionDetails.map((i) => i.toMap()).toList(),
    };
  }
}
