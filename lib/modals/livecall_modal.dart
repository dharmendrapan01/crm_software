class LiveCallModal {
  List<Response>? response;
  Response1? response1;
  Response2? response2;

  LiveCallModal({this.response, this.response1, this.response2});

  LiveCallModal.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
    response1 = json['response1'] != null
        ? new Response1.fromJson(json['response1'])
        : null;
    response2 = json['response2'] != null
        ? new Response2.fromJson(json['response2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    if (this.response1 != null) {
      data['response1'] = this.response1!.toJson();
    }
    if (this.response2 != null) {
      data['response2'] = this.response2!.toJson();
    }
    return data;
  }
}

class Response {
  int? id;
  int? userId;
  String? clientId;
  String? callId;
  int? direction;
  String? source;
  String? type;
  String? did;
  String? multipleDestinationType;
  String? multipleDestinationName;
  String? destination;
  String? state;
  Null? queueState;
  String? channelId;
  String? createdAt;
  String? sipDomain;
  Null? broadcastId;
  Null? broadcastNo;
  String? callTime;
  String? agentName;
  String? customerNumber;

  Response(
      {this.id,
        this.userId,
        this.clientId,
        this.callId,
        this.direction,
        this.source,
        this.type,
        this.did,
        this.multipleDestinationType,
        this.multipleDestinationName,
        this.destination,
        this.state,
        this.queueState,
        this.channelId,
        this.createdAt,
        this.sipDomain,
        this.broadcastId,
        this.broadcastNo,
        this.callTime,
        this.agentName,
        this.customerNumber});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientId = json['client_id'];
    callId = json['call_id'];
    direction = json['direction'];
    source = json['source'];
    type = json['type'];
    did = json['did'];
    multipleDestinationType = json['multiple_destination_type'];
    multipleDestinationName = json['multiple_destination_name'];
    destination = json['destination'];
    state = json['state'];
    queueState = json['queue_state'];
    channelId = json['channel_id'];
    createdAt = json['created_at'];
    sipDomain = json['sip_domain'];
    broadcastId = json['broadcast_id'];
    broadcastNo = json['broadcast_no'];
    callTime = json['call_time'];
    agentName = json['agent_name'];
    customerNumber = json['customer_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['client_id'] = this.clientId;
    data['call_id'] = this.callId;
    data['direction'] = this.direction;
    data['source'] = this.source;
    data['type'] = this.type;
    data['did'] = this.did;
    data['multiple_destination_type'] = this.multipleDestinationType;
    data['multiple_destination_name'] = this.multipleDestinationName;
    data['destination'] = this.destination;
    data['state'] = this.state;
    data['queue_state'] = this.queueState;
    data['channel_id'] = this.channelId;
    data['created_at'] = this.createdAt;
    data['sip_domain'] = this.sipDomain;
    data['broadcast_id'] = this.broadcastId;
    data['broadcast_no'] = this.broadcastNo;
    data['call_time'] = this.callTime;
    data['agent_name'] = this.agentName;
    data['customer_number'] = this.customerNumber;
    return data;
  }
}

class Response1 {
  String? leadId;
  String? customerName;
  String? loginId;
  String? agentId;
  String? deptId;
  int? leaderCount;

  Response1(
      {this.leadId,
        this.customerName,
        this.loginId,
        this.agentId,
        this.deptId,
        this.leaderCount});

  Response1.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    customerName = json['customer_name'];
    loginId = json['login_id'];
    agentId = json['agent_id'];
    deptId = json['dept_id'];
    leaderCount = json['leader_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['customer_name'] = this.customerName;
    data['login_id'] = this.loginId;
    data['agent_id'] = this.agentId;
    data['dept_id'] = this.deptId;
    data['leader_count'] = this.leaderCount;
    return data;
  }
}

class Response2 {
  int? agentNo;
  String? intercomId;

  Response2({this.agentNo, this.intercomId});

  Response2.fromJson(Map<String, dynamic> json) {
    agentNo = json['agent_no'];
    intercomId = json['intercom_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agent_no'] = this.agentNo;
    data['intercom_id'] = this.intercomId;
    return data;
  }
}
