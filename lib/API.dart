const url = "http://78.111.61.8:90/api";

const rawUrl = "http://78.111.61.8:90/";

const createProfilePost = url + "/users";

const checkUserGet = url + "/users/CheckUsers";

getImage(name){
  return rawUrl +"images/"+ name;
}

getUserGet(id, token) {
  return url + "/users/$id?token=$token";
}

getHistory(code, range, token){
  return url + "/History/gethistory?code=$code&range=$range&token=$token";
}
getPartners(code, range, token){
  return url + "/Partner/getPartner?code=$code&range=$range&token=$token";
}

Map<String, String> header = {
  "Authorization": "Basic Tm93dGVhbTo1NTkxOTgwTm93",
};

class RegistrationInformation {
  String eEmail;
  String phone;
  String password;
  RegistrationInformation(this.eEmail, this.phone, this.password);
}

class LogResponse {
  final int id;
  final String token;
  final bool isFound;
  final bool isPassCorrect;

  LogResponse({this.id, this.token, this.isFound, this.isPassCorrect});

  factory LogResponse.fromJson(Map<String, dynamic> json) {
    return LogResponse(
        id: json['id'] as int,
        token: json['token'] as String,
        isFound: json['isFound'] as bool,
        isPassCorrect: json['isPassCorrect'] as bool);
  }
}

class UserInfo {
  final int id;

  final String name;

  final String surname;

  final String date;

  final String imgName;

  final bool isMale;

  final int bonus;

  final String token;

  UserInfo({this.id, this.name, this.surname, this.date, this.imgName, this.isMale, this.bonus, this.token});

  factory UserInfo.fromJson(Map<String,dynamic> json){
    return UserInfo(
      id: json["Id"] as int,
      name: json["Name"] as String,
      surname: json["Surname"] as String,
      date: json["Date"] as String,
      imgName: json["ImgName"] as String,
      isMale: json["IsMale"] as bool,
      bonus: json["Bonus"] as int,
      token: json["Token"] as String
    );
  }
}

class HistoryApi{
  final int userId;
  final String capturedAt;
  final int bonus;
  final String companyName;
  final int id;
  final String image;

  HistoryApi({this.bonus, this.userId, this.capturedAt, this.id, this.companyName,this.image});

  factory HistoryApi.fromJson(Map<String,dynamic> json){
    return HistoryApi(
      id: json["Id"] as int,
      userId: json["UserID"] as int,
      capturedAt: json["CapturedAt"] as String,
      companyName: json["CompanyName"] as String,
      bonus: json["Bonus"] as int,
      image: json["Image"] as String,
    );
  }

}

class PartnerAPI{
  final String companyName;
  final String details;
  final int adsCount;
  final String image;
  final String mapLink;

  PartnerAPI({this.companyName, this.details, this.adsCount, this.image, this.mapLink});

  factory PartnerAPI.fromJson(Map<String,dynamic> json){
    return PartnerAPI(
      companyName: json['CompanyName'],
      details: json['Details'],
      adsCount: json['AdsCount'],
      image: json['Image'],
      mapLink: json['MapLink'],
    );
  }

}



