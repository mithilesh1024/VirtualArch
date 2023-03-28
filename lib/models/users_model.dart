class UserModel {
  final String uid;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final List? models;
  final List? clients;
  final List? skills;

  UserModel({
    required this.uid,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    this.models,
    this.clients,
    this.skills,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'address': address,
        'email': email,
        'phoneNumber': phoneNumber,
        'models': [],
        'clients': [],
        'skills': [],
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        address: json['address'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        models: json['models'],
        clients: json['clients'],
        skills: json['skills'],
      );
}
