import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oxidized/oxidized.dart';

import '../models/models.dart';

abstract class AssociatesRepository {
  Future<Result<List<Associate>, AppError>> getAssociates();

  Future<Result<void, AppError>> editAssociate(String associateId);

  Future<Result<List<ItemConsumed>, AppError>> getItemsConsumed(
    String associateId,
  );

  Future<Result<void, AppError>> createItemConsumed(
    String associateId,
    ItemConsumed itemConsumed,
  );

  Future<Result<void, AppError>> editItemConsumed(
    String associateId,
    String itemConsumedId,
    ItemConsumed itemConsumed,
  );

  Future<Result<void, AppError>> deleteItemConsumed(
    String associateId,
    String itemConsumedId,
  );

  Future<Result<List<Loan>, AppError>> getLoans(String associateId);

  Future<Result<void, AppError>> createLoan(String associateId, Loan loan);

  Future<Result<void, AppError>> editLoan(
    String associateId,
    String loanId,
    Loan loan,
  );

  Future<Result<void, AppError>> deleteLoan(String associateId, String loanId);
}

class AssociatesRepositoryImpl implements AssociatesRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collectionPath = 'associates';
  final _firebaseAppError = AppErrorCode.firestoreError;

  @override
  Future<Result<List<Associate>, AppError>> getAssociates() async {
    try {
      final documents = await _firestore.collection(_collectionPath).get();
      return Result.ok(List<Associate>.from(
          documents.docs.map((doc) => Associate.fromDocument(doc)).toList()));
    } catch (e) {
      log(e.toString());
      return Result.err(
        AppError(
          errorCode: _firebaseAppError,
          message: _firebaseAppError.message,
        ),
      );
    }
  }

  @override
  Future<Result<void, AppError>> editAssociate(String associateId) {
    // TODO: implement editAssociate
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ItemConsumed>, AppError>> getItemsConsumed(
      String associateId) {
    // TODO: implement getItemsConsumedByAssociate
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> createItemConsumed(
      String associateId, ItemConsumed itemConsumed) {
    // TODO: implement createItemConsumed
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editItemConsumed(
      String associateId, String itemConsumedId, ItemConsumed itemConsumed) {
    // TODO: implement editItemConsumed
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> deleteItemConsumed(
      String associateId, String itemConsumedId) {
    // TODO: implement deleteItemConsumed
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Loan>, AppError>> getLoans(String associateId) {
    // TODO: implement getLoansByAssociate
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> createLoan(String associateId, Loan loan) {
    // TODO: implement createLoan
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editLoan(
      String associateId, String loanId, Loan loan) {
    // TODO: implement editLoan
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> deleteLoan(String associateId, String loanId) {
    // TODO: implement deleteLoan
    throw UnimplementedError();
  }
}
