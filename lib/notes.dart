class NotesModal {
  int? id;
  String? title;

  String? email;

  NotesModal({ this.id,this.title,  this.email});

  NotesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];

    email = json['email'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;

    data['email'] = this.email;
    return data;
  }
}
