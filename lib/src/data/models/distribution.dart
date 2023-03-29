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
    return Distribution(
      map['id'],
      DateTime.parse(map['dateTime']),
      map['totalDistributed'],
      List<IndividualDistributionDetails>.from(
        map['individualDistributionDetails']
            .map((i) => IndividualDistributionDetails.fromDocument(i))
            .toList(),
      ),
    );
  }
}
