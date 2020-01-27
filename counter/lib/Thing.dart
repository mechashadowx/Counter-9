class Thing {
  final String key;
  final String name;
  final int value;
  final bool open;

  Thing(this.key, this.name, this.value, this.open);

  Map toMap() {
    return {
      'key': key,
      'name': name,
      'value': value,
      'open': open,
    };
  }
}
