import 'package:oxidized/oxidized.dart';

import '../models/models.dart';

abstract class CompanyRepository {
  Future<Result<Company, AppError>> getCompany();

  Future<Result<void, AppError>> editCompany(String companyId);

  Future<Result<List<Item>, AppError>> getItems(String companyId);

  Future<Result<void, AppError>> createItem(Item item);

  Future<Result<void, AppError>> editItem(String itemId, Item item);

  Future<Result<void, AppError>> deleteItem(String itemId);

  Future<Result<List<Distribution>, AppError>> getDistributions(
      String companyId);

  Future<Result<void, AppError>> createDistribution(Distribution distribution);

  Future<Result<void, AppError>> editDistributions(
    String distributionId,
    Distribution distribution,
  );

  Future<Result<void, AppError>> deleteDistribution(String distributionId);
}

class CompanyRepositoryImpl implements CompanyRepository {
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
  Future<Result<void, AppError>> editCompany(String companyId) {
    // TODO: implement editCompany
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editDistributions(
      String distributionId, Distribution distribution) {
    // TODO: implement editDistributions
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> editItem(String itemId, Item item) {
    // TODO: implement editItem
    throw UnimplementedError();
  }

  @override
  Future<Result<Company, AppError>> getCompany() {
    // TODO: implement getCompany
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Distribution>, AppError>> getDistributions(
      String companyId) {
    // TODO: implement getDistributions
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Item>, AppError>> getItems(String companyId) {
    // TODO: implement getItems
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
}
