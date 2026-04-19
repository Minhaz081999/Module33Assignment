class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String city;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.city,
    required this.avatarUrl,
  });
//------------- from JSON TO Object Conversion ----------------
  factory UserModel.fromJson( Map<String, dynamic>json ){
    return UserModel(
        id: json['_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        city: json['city'],
        avatarUrl: json['avatar_url']
    );
  }
//----------- from Object to JSON/Map<> Conversion ------------------
  Map<String, dynamic >tojson(){
    return {
      '_id' : id,
      'first_name' : firstName,
      'last_name' : lastName,
      'email' : email,
      'phone' : phone,
      'city' : city,
      'avatar_url' : avatarUrl
    };
  }
}
