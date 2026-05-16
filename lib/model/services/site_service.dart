import '../models/site_model.dart';

class SiteService {
  Future<List<SiteModel>> fetchSites() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate network delay
    return [
      SiteModel(
        id: '1',
        name: 'Alpha Industrial Park',
        location: 'Mumbai, Maharashtra',
        managerName: 'Rahul Nair',
        managerContact: '+91 98765 43210',
        gpsLat: '19.0760° N',
        gpsLng: '72.8777° E',
        status: SiteStatus.active,
      ),
      SiteModel(
        id: '2',
        name: 'Beta Processing Unit',
        location: 'Pune, Maharashtra',
        managerName: 'Priya Sharma',
        managerContact: '+91 91234 56789',
        gpsLat: '18.5204° N',
        gpsLng: '73.8567° E',
        status: SiteStatus.maintenance,
      ),
      SiteModel(
        id: '3',
        name: 'Gamma Logistics Hub',
        location: 'Chennai, Tamil Nadu',
        managerName: 'Arjun Menon',
        managerContact: '+91 87654 32109',
        gpsLat: '13.0827° N',
        gpsLng: '80.2707° E',
        status: SiteStatus.active,
      ),
      SiteModel(
        id: '4',
        name: 'Delta Data Centre',
        location: 'Bengaluru, Karnataka',
        managerName: 'Sneha Reddy',
        managerContact: '+91 99887 76655',
        gpsLat: '12.9716° N',
        gpsLng: '77.5946° E',
        status: SiteStatus.active,
      ),
      SiteModel(
        id: '5',
        name: 'Epsilon Cold Storage',
        location: 'Kochi, Kerala',
        managerName: 'Anil Kumar',
        managerContact: '+91 94455 66778',
        gpsLat: '9.9312° N',
        gpsLng: '76.2673° E',
        status: SiteStatus.maintenance,
      ),
      SiteModel(
        id: '6',
        name: 'Zeta Assembly Plant',
        location: 'Hyderabad, Telangana',
        managerName: 'Divya Pillai',
        managerContact: '+91 98001 23456',
        gpsLat: '17.3850° N',
        gpsLng: '78.4867° E',
        status: SiteStatus.active,
      ),
    ];
  }
}
