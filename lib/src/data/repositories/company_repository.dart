import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oxidized/oxidized.dart';

import '../models/models.dart';

abstract class CompanyRepository {
  Future<Result<Company, AppError>> getCompany();

  Future<Result<void, AppError>> editCompany(String companyId, Company company);

  Future<Result<List<Item>, AppError>> getItems(String companyId);

  Future<Result<void, AppError>> createItem(String companyId, Item item);

  Future<Result<void, AppError>> editItem(
    String companyId,
    Item item,
  );

  Future<Result<void, AppError>> deleteItem(String companyId, String itemId);

  Future<Result<List<Distribution>, AppError>> getDistributions(
    String companyId,
  );

  Future<Result<void, AppError>> createDistribution(
    String companyId,
    Distribution distribution,
  );

  Future<Result<void, AppError>> editDistribution(
    String companyId,
    String distributionId,
    Distribution distribution,
  );

  Future<Result<void, AppError>> deleteDistribution(
    String company,
    String distributionId,
  );
}

class CompanyRepositoryImpl implements CompanyRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collectionPath = 'company';
  final _firebaseAppError = AppErrorCode.firestoreError;

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
  Future<Result<void, AppError>> editCompany(
      String companyId, Company company) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update(company.toMap());

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

  @override
  Future<Result<void, AppError>> createItem(String companyId, Item item) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final items = List<Item>.from(company.items);

      items.add(item);

      await _firestore.collection(_collectionPath).doc(companyId).update(
        {'items': items.map((i) => i.toMap())},
      );

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
  Future<Result<void, AppError>> editItem(String companyId, Item item) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final items = List<Item>.from(company.items);

      if (!items.any((element) => element.id == item.id)) {
        return Result.err(
          AppError(
            errorCode: AppErrorCode.validationError,
            message: 'Item not found.',
          ),
        );
      }

      items[items.indexWhere((element) => element.id == item.id)] = item;
      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update({'items': items.map((i) => i.toMap())});

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
  Future<Result<void, AppError>> deleteItem(
      String companyId, String itemId) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final items = List<Item>.from(company.items);

      if (!items.any((element) => element.id == itemId)) {
        return Result.err(
          AppError(
            errorCode: AppErrorCode.validationError,
            message: 'Item not found.',
          ),
        );
      }

      items.removeWhere((element) => element.id == itemId);
      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update({'items': items.map((i) => i.toMap())});

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
  Future<Result<void, AppError>> createDistribution(
      String companyId, Distribution distribution) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final distributions = List<Distribution>.from(company.distributions);

      distributions.add(distribution);

      await _firestore.collection(_collectionPath).doc(companyId).update(
        {'distributions': distributions.map((d) => d.toMap())},
      );

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
  Future<Result<void, AppError>> editDistribution(String companyId,
      String distributionId, Distribution distribution) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final distributions = List<Distribution>.from(company.distributions);

      if (!distributions.any((element) => element.id == distribution.id)) {
        return Result.err(
          AppError(
            errorCode: AppErrorCode.validationError,
            message: 'Distribution not found.',
          ),
        );
      }

      distributions[distributions.indexWhere(
          (element) => element.id == distribution.id)] = distribution;

      await _firestore
          .collection(_collectionPath)
          .doc(companyId)
          .update({'distributions': distributions.map((d) => d.toMap())});

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
  Future<Result<void, AppError>> deleteDistribution(
      String companyId, String distributionId) async {
    try {
      final document =
          await _firestore.collection(_collectionPath).doc(companyId).get();
      final company = Company.fromDocument(document);
      final distributions = List<Distribution>.from(company.distributions);

      if (!distributions.any((element) => element.id == distributionId)) {
        return Result.err(
          AppError(
            errorCode: AppErrorCode.validationError,
            message: 'Distribution not found.',
          ),
        );
      }

      distributions.removeWhere((element) => element.id == distributionId);
      await _firestore.collection(_collectionPath).doc(companyId).update(
        {'distributions': distributions.map((d) => d.toMap())},
      );

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
}
