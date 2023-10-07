// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  dynamic doctorId;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic phone;
  dynamic phoneTwo;
  dynamic uuid;
  int? isVerified;
  String? avatar;
  dynamic bio;
  dynamic dob;
  dynamic age;
  dynamic gender;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic profileType;
  dynamic specializations;
  dynamic education;
  dynamic work;
  dynamic paymentDetails;
  dynamic pincode;
  dynamic address;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  dynamic title;
  dynamic provider;
  dynamic providerId;
  dynamic tempOtp;
  dynamic timeslot;
  int? feePerSlot;
  dynamic secondOpinionFee;
  dynamic scannerImage;
  dynamic hospital;
  dynamic hospitalLogo;
  int? sequence;
  int? isFeatured;
  int? isPublished;
  dynamic offerBanner;
  dynamic fcmToken;
  String? role;
  dynamic patients;
  dynamic investigation;
  dynamic todayAppointments;
  dynamic accessCode;

  UserModel({
    this.id,
    this.doctorId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneTwo,
    this.uuid,
    this.isVerified,
    this.avatar,
    this.bio,
    this.dob,
    this.age,
    this.gender,
    this.country,
    this.state,
    this.city,
    this.profileType,
    this.specializations,
    this.education,
    this.work,
    this.paymentDetails,
    this.pincode,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.title,
    this.provider,
    this.providerId,
    this.tempOtp,
    this.timeslot,
    this.feePerSlot,
    this.secondOpinionFee,
    this.scannerImage,
    this.hospital,
    this.hospitalLogo,
    this.sequence,
    this.isFeatured,
    this.isPublished,
    this.offerBanner,
    this.fcmToken,
    this.role,
    this.patients,
    this.investigation,
    this.todayAppointments,
    this.accessCode,
  });

  UserModel copyWith({
    int? id,
    dynamic doctorId,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    dynamic phone,
    dynamic phoneTwo,
    dynamic uuid,
    int? isVerified,
    String? avatar,
    dynamic bio,
    dynamic dob,
    dynamic age,
    dynamic gender,
    dynamic country,
    dynamic state,
    dynamic city,
    dynamic profileType,
    dynamic specializations,
    dynamic education,
    dynamic work,
    dynamic paymentDetails,
    dynamic pincode,
    dynamic address,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? status,
    dynamic title,
    dynamic provider,
    dynamic providerId,
    dynamic tempOtp,
    dynamic timeslot,
    int? feePerSlot,
    dynamic secondOpinionFee,
    dynamic scannerImage,
    dynamic hospital,
    dynamic hospitalLogo,
    int? sequence,
    int? isFeatured,
    int? isPublished,
    dynamic offerBanner,
    dynamic fcmToken,
    String? role,
    dynamic patients,
    dynamic investigation,
    dynamic todayAppointments,
    dynamic accessCode,
  }) =>
      UserModel(
        id: id ?? this.id,
        doctorId: doctorId ?? this.doctorId,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        phone: phone ?? this.phone,
        phoneTwo: phoneTwo ?? this.phoneTwo,
        uuid: uuid ?? this.uuid,
        isVerified: isVerified ?? this.isVerified,
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        profileType: profileType ?? this.profileType,
        specializations: specializations ?? this.specializations,
        education: education ?? this.education,
        work: work ?? this.work,
        paymentDetails: paymentDetails ?? this.paymentDetails,
        pincode: pincode ?? this.pincode,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        title: title ?? this.title,
        provider: provider ?? this.provider,
        providerId: providerId ?? this.providerId,
        tempOtp: tempOtp ?? this.tempOtp,
        timeslot: timeslot ?? this.timeslot,
        feePerSlot: feePerSlot ?? this.feePerSlot,
        secondOpinionFee: secondOpinionFee ?? this.secondOpinionFee,
        scannerImage: scannerImage ?? this.scannerImage,
        hospital: hospital ?? this.hospital,
        hospitalLogo: hospitalLogo ?? this.hospitalLogo,
        sequence: sequence ?? this.sequence,
        isFeatured: isFeatured ?? this.isFeatured,
        isPublished: isPublished ?? this.isPublished,
        offerBanner: offerBanner ?? this.offerBanner,
        fcmToken: fcmToken ?? this.fcmToken,
        role: role ?? this.role,
        patients: patients ?? this.patients,
        investigation: investigation ?? this.investigation,
        todayAppointments: todayAppointments ?? this.todayAppointments,
        accessCode: accessCode ?? this.accessCode,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    doctorId: json["doctor_id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    phoneTwo: json["phone_two"],
    uuid: json["uuid"],
    isVerified: json["is_verified"],
    avatar: json["avatar"],
    bio: json["bio"],
    dob: json["dob"],
    age: json["age"],
    gender: json["gender"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    profileType: json["profile_type"],
    specializations: json["specializations"],
    education: json["education"],
    work: json["work"],
    paymentDetails: json["payment_details"],
    pincode: json["pincode"],
    address: json["address"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    status: json["status"],
    title: json["title"],
    provider: json["provider"],
    providerId: json["provider_id"],
    tempOtp: json["temp_otp"],
    timeslot: json["timeslot"],
    feePerSlot: json["fee_per_slot"],
    secondOpinionFee: json["second_opinion_fee"],
    scannerImage: json["scanner_image"],
    hospital: json["hospital"],
    hospitalLogo: json["hospital_logo"],
    sequence: json["sequence"],
    isFeatured: json["is_featured"],
    isPublished: json["is_published"],
    offerBanner: json["offer_banner"],
    fcmToken: json["fcm_token"],
    role: json["role"],
    patients: json["patients"],
    investigation: json["investigation"],
    todayAppointments: json["today_appointments"],
    accessCode: json["access_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "phone_two": phoneTwo,
    "uuid": uuid,
    "is_verified": isVerified,
    "avatar": avatar,
    "bio": bio,
    "dob": dob,
    "age": age,
    "gender": gender,
    "country": country,
    "state": state,
    "city": city,
    "profile_type": profileType,
    "specializations": specializations,
    "education": education,
    "work": work,
    "payment_details": paymentDetails,
    "pincode": pincode,
    "address": address,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "title": title,
    "provider": provider,
    "provider_id": providerId,
    "temp_otp": tempOtp,
    "timeslot": timeslot,
    "fee_per_slot": feePerSlot,
    "second_opinion_fee": secondOpinionFee,
    "scanner_image": scannerImage,
    "hospital": hospital,
    "hospital_logo": hospitalLogo,
    "sequence": sequence,
    "is_featured": isFeatured,
    "is_published": isPublished,
    "offer_banner": offerBanner,
    "fcm_token": fcmToken,
    "role": role,
    "patients": patients,
    "investigation": investigation,
    "today_appointments": todayAppointments,
    "access_code": accessCode,
  };
}
