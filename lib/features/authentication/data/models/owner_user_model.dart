import 'package:cairn/features/authentication/domain/entities/owner_user.dart';

class OwnerUserModel extends OwnerUser {
  const OwnerUserModel({
    required super.id,
    required super.fullName,
    required super.companyName,
    required super.email,
    required super.phone,
  });

  factory OwnerUserModel.fromMap(Map<String, dynamic> map) {
    return OwnerUserModel(
      id: map['id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      companyName: map['companyName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
    );
  }
}