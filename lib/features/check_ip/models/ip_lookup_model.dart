class IpLookupModel {
  String? ip;
  String? hostname;
  String? domain;
  String? asnNumber;
  String? country;
  String? countryCode;
  String? region;
  String? zipCode;
  String? city;
  String? stateCode;
  double? longitude;
  double? latitude;
  String? isp;
  int? ispAsn;

  IpLookupModel(
      {this.ip,
        this.hostname,
        this.domain,
        this.asnNumber,
        this.country,
        this.countryCode,
        this.region,
        this.zipCode,
        this.city,
        this.stateCode,
        this.longitude,
        this.latitude,
        this.isp,
        this.ispAsn});

  IpLookupModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    hostname = json['hostname'];
    domain = json['domain'];
    asnNumber = json['asn_number'];
    country = json['country'];
    countryCode = json['country_code'];
    region = json['region'];
    zipCode = json['zip_code'];
    city = json['city'];
    stateCode = json['state_code'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isp = json['isp'];
    ispAsn = json['isp_asn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['hostname'] = this.hostname;
    data['domain'] = this.domain;
    data['asn_number'] = this.asnNumber;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['region'] = this.region;
    data['zip_code'] = this.zipCode;
    data['city'] = this.city;
    data['state_code'] = this.stateCode;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['isp'] = this.isp;
    data['isp_asn'] = this.ispAsn;
    return data;
  }
}
