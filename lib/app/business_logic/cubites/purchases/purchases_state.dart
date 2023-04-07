part of 'purchases_cubit.dart';

@immutable
abstract class PurchasesState {}

class PurchasesLoading extends PurchasesState {}

class PurchasesInitFailed extends PurchasesState {}

class PurchasesReady extends PurchasesState {}

class PurchasesError extends PurchasesState {}

class PurchasesCanceled extends PurchasesState {}

class PurchasesSuccess extends PurchasesState {}

class PurchasesRestored extends PurchasesState {}
