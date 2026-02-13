import 'package:equatable/equatable.dart';

class User extends Equatable {
    final String id;
    final String email;
    final String? username;
    final String? fullname;
    final String? avatarUrl;

    const User({
        required this.id,
        required this.email,
        this.username,
        this.fullname,
        this.avatarUrl,
    });

    @override
    List<Object?> get props => [id, email, username, fullname, avatarUrl];
}