import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oxidized/oxidized.dart';

import '../models/models.dart';

abstract class CompanyRepository {
  Future<Result<Company, AppError>> getCompany();

  Future<Result<void, AppError>> editCompany(String companyId, Company company);

  Future<Result<List<Item>, AppError>> getItems(String companyId);

  Future<Result<void, AppError>> createItem(Item item);

  Future<Result<void, AppError>> editItem(
    String companyId,
    String itemId,
    Item item,
  );

  Future<Result<void, AppError>> deleteItem(String itemId);

  Future<Result<List<Distribution>, AppError>> getDistributions(
      String companyId);

  Future<Result<void, AppError>> createDistribution(Distribution distribution);

  Future<Result<void, AppError>> editDistribution(
    String companyId,
    String distributionId,
    Distribution distribution,
  );

  Future<Result<void, AppError>> deleteDistribution(String distributionId);
}

class CompanyRepositoryImpl implements CompanyRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collectionPath = 'company';
  final _firebaseAppError = AppErrorCode.firestoreError;

  @override
  Future<Result<void, AppError>> createDistribution(Distribution distribution) {
    // TODO: implement createDistribution
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> createItem(Item item) {
    // TODO: implement createItem
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> deleteDistribution(String distributionId) {
    // TODO: implement deleteDistribution
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> deleteItem(String itemId) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editCompany(
      String companyId, Company company) {
    // TODO: implement editCompany
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editDistribution(String companyId,
      String distributionId, Distribution distribution) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update(distribution.toMap());
      return Result.ok(true);
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
  Future<Result<void, AppError>> editItem(
      String companyId, String itemId, Item item) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update(item.toMap());
      return Result.ok(true);
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
  Future<Result<Company, AppError>> getCompany() async {
    try {
      final documents = await _firestore.collection(_collectionPath).get();
      return Result.ok(Company.fromDocument(documents.docs[0]));
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
  Future<Result<List<Distribution>, AppError>> getDistributions(
      String companyId) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      return Result.ok(company.distributions);
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
  Future<Result<List<Item>, AppError>> getItems(String companyId) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      return Result.ok(company.items);
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
}
