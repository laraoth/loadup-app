class UpdateComplaintsRequestModel {
  int? complaintId;
  String description;

  UpdateComplaintsRequestModel({
    this.complaintId,
    required this.description,
  });

  factory UpdateComplaintsRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateComplaintsRequestModel(
        complaintId: json["complaint_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "complaint_id": complaintId,
        "description": description,
      };
}
