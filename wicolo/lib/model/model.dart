class Sentence {
  final int id;
  final String name;
  final int sentenceType;

  Sentence({this.id, this.name, this.sentenceType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sentenceType': sentenceType,
          };
  }

  // Implement toString to make it easier to see information about
  // each sentence when using the print statement.
  @override
  String toString() {
    return 'Sentence{id: $id, name: $name,  sentenceType $sentenceType}';
  }
}