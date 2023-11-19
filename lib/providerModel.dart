const providerPhone = 'phone';
const providerName = 'name';
const providerEmail = 'email';
const providerAddress = 'address';
const providerImage = 'image';
const providerType = 'type';
const providerScore='score';


class providerModel{
  String address;
  String email;
  String image;
  String name;
  String phone;
  String type;
  int score;

  providerModel({
    required this.phone,
    this.name = '',
    required this.email,
    required this.address,
    this.image = '',
    required this.type,
    this.score=0,
  });

  Map<String, dynamic> toMap(){
    final Map = <String, dynamic>{
      providerPhone : phone,
      providerName : name,
      providerEmail : email,
      providerAddress : address,
      providerImage : image,
      providerType: type,
      providerScore: score,
    };
    return Map;
  }

  factory providerModel.fromMap(Map<String, dynamic> map) => providerModel(
    phone: map[providerPhone],
    name: map[providerName],
    email: map[providerEmail],
    address: map[providerAddress],
    image: map[providerImage],
    type: map[providerType],
    score: map[providerScore],
  );
}