import 'package:equatable/equatable.dart';

class OwnerUser extends Equatable {
  const OwnerUser({
    required this.id,
    required this.fullName,
    required this.companyName,
    required this.email,
    required this.phone,
  });

  final String id;
  final String fullName;
  final String companyName;
  final String email;
  final String phone;

  @override
  List<Object?> get props => [id, fullName, companyName, email, phone];
}