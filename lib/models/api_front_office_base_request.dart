class ApiFrontOfficeBaseRequest {
  ///your ALIAS backend provided by nexi
  late String alias;
  String? timeStamp;
  String? mac;
  String clientType = '';
  Map<String, String>? extraKeys;

  ApiFrontOfficeBaseRequest(this.alias);

  ApiFrontOfficeBaseRequest.map(dynamic obj) {
    alias = obj['alias'];
    timeStamp = obj['timeStamp'];
    mac = obj['mac'];
    clientType = obj['clientType'];
    extraKeys = obj['extraKeys'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['alias'] = alias;
    map['timeStamp'] = timeStamp;
    map['mac'] = mac;
    map['clientType'] = clientType;
    map['extraKeys'] = extraKeys;
    return map;
  }
}
