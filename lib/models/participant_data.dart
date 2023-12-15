import 'package:equatable/equatable.dart';

class ParticipantData extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String participantId;

  const ParticipantData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.participantId,
  });

  factory ParticipantData.fromJson(Map<String, dynamic> json) {
    return ParticipantData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      participantId: json['participant_id'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        address,
        city,
        state,
        zip,
        participantId,
      ];
}
