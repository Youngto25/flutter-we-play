class Finish {
  String type;
  int count;
  DateTime createdTime;
  Finish(String type, int count, DateTime createdTime) {
    this.type = type;
    this.count = count;
    this.createdTime = createdTime;
  }
  getCount() {
    return this.count;
  }
  getType() {
    return this.type;
  }
  getCreatedTime() {
    return this.createdTime;
  }
}