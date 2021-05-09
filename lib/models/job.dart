class Job {
  String title, description, location;

  Job({this.title, this.description, this.location});

  factory Job.fromJson(Map<String, dynamic> map) {
    return Job(
      title: map['title'],
      description: map['description'],
      location: map['location'],
    );
  }
}
