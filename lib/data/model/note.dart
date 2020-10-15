//variable initialization
class Note {
  final String appID;
  final String doctorName;
  final String healthIssue;
  final String hospital;
  final String id;
  final String date;
  final String time;
  var searchlist;

  Note({
    this.appID,
    this.doctorName,
    this.healthIssue,
    this.hospital,
    this.id,
    this.date,
    this.time,
    this.searchlist,
  });

  Note.fromMap(Map<String, dynamic> data, String id)
      : appID = data["appID"],
        doctorName = data['doctorName'],
        healthIssue = data['healthIssue'],
        hospital = data['hospital'],
        date = data['date'],
        time = data['time'],
        searchlist = data['searchlist'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "appID": appID,
      "doctorName": doctorName,
      "healthIssue": healthIssue,
      "hospital": hospital,
      "date": date,
      "time": time,
      "searchlist": searchlist
    };
  }
}
