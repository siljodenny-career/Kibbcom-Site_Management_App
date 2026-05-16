enum SiteStatus { active, maintenance }

class SiteModel {
  final String id;
  final String name;
  final String location;
  final String managerName;
  final String managerContact;
  final String gpsLat;
  final String gpsLng;
  SiteStatus status;

  SiteModel({
    required this.id,
    required this.name,
    required this.location,
    required this.managerName,
    required this.managerContact,
    required this.gpsLat,
    required this.gpsLng,
    this.status = SiteStatus.active,
  });

  SiteModel copyWith({SiteStatus? status}) {
    return SiteModel(
      id: id,
      name: name,
      location: location,
      managerName: managerName,
      managerContact: managerContact,
      gpsLat: gpsLat,
      gpsLng: gpsLng,
      status: status ?? this.status,
    );
  }
}
