class Version{
  int id; 
  int versionNum;
    Version({this.id, this.versionNum});

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'versionNum': versionNum,
          };
  }
}