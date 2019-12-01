class SentenceDTO{
  String name; 
  int queryTypeId;
    SentenceDTO({this.name, this.queryTypeId}) ;
  SentenceDTO.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        queryTypeId = json['questType'];
}