class ProfileModel {
  String uid; //идентификатор
  String name; // Имя
  String surName; //фамилия
  String phone; // номер телефона
  String gender; // Пол
  String age; // Возрост

  ProfileModel(
      {this.uid = '',
      this.name = '',
      this.surName = '',
      this.phone = '',
      this.gender = '',
      this.age = ''});

  factory ProfileModel.fromJson(Map json) => ProfileModel(
      uid: json['uid'] ?? null,
      name: json['name'] ?? null,
      surName: json['surname'] ?? null,
      phone: json['phone'] ?? null,
      gender: json['gender'] ?? null,
      age: json['age'] ?? null);
}
