import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.imageUrl,
    required this.emailVerified,
    required this.isAnonymous,
    required this.phoneNumber,
  });

  final String id;
  final String? fullName;
  final String? email;
  final bool emailVerified;
  final String? imageUrl;
  final bool isAnonymous;
  final String? phoneNumber;

  factory UserEntity.empty() => UserEntity(
        id: '',
        fullName: null,
        email: null,
        imageUrl: null,
        emailVerified: false,
        isAnonymous: false,
        phoneNumber: 'phoneNumber',
      );

  @override
  List<Object?> get props => [id, fullName, email, emailVerified, imageUrl, isAnonymous, phoneNumber];
}
