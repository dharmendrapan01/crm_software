class AgentListModal {
  List<Agentlist>? agentlist;

  AgentListModal({this.agentlist});

  AgentListModal.fromJson(Map<String, dynamic> json) {
    if (json['agentlist'] != null) {
      agentlist = <Agentlist>[];
      json['agentlist'].forEach((v) {
        agentlist!.add(new Agentlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agentlist != null) {
      data['agentlist'] = this.agentlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agentlist {
  int? id;
  String? name;
  String? followMeNumber;
  String? eid;
  String? intercom;
  int? callsAnswered;
  int? callsMissed;
  int? teamId;
  String? teamName;
  int? customStatus;
  Null? timegroupName;
  Null? timegroupId;
  Null? failoverDestination;
  Null? failoverDestinationName;
  int? isVerified;
  List<Departments>? departments;
  List<AllowedCallerIds>? allowedCallerIds;
  bool? agentCdr;
  bool? associatedAgent;
  List<Null>? agentGroups;
  StickySettings? stickySettings;

  Agentlist(
      {this.id,
        this.name,
        this.followMeNumber,
        this.eid,
        this.intercom,
        this.callsAnswered,
        this.callsMissed,
        this.teamId,
        this.teamName,
        this.customStatus,
        this.timegroupName,
        this.timegroupId,
        this.failoverDestination,
        this.failoverDestinationName,
        this.isVerified,
        this.departments,
        this.allowedCallerIds,
        this.agentCdr,
        this.associatedAgent,
        this.agentGroups,
        this.stickySettings});

  Agentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    followMeNumber = json['follow_me_number'];
    eid = json['eid'];
    intercom = json['intercom'];
    callsAnswered = json['calls_answered'];
    callsMissed = json['calls_missed'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    customStatus = json['custom_status'];
    timegroupName = json['timegroup_name'];
    timegroupId = json['timegroup_id'];
    failoverDestination = json['failover_destination'];
    failoverDestinationName = json['failover_destination_name'];
    isVerified = json['is_verified'];
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
    if (json['allowed_caller_ids'] != null) {
      allowedCallerIds = <AllowedCallerIds>[];
      json['allowed_caller_ids'].forEach((v) {
        allowedCallerIds!.add(new AllowedCallerIds.fromJson(v));
      });
    }
    agentCdr = json['agent_cdr'];
    associatedAgent = json['associated_agent'];
    if (json['agent_groups'] != null) {
      agentGroups = <Null>[];
      json['agent_groups'].forEach((v) {
        // agentGroups!.add(new Null.fromJson(v));
      });
    }
    stickySettings = json['sticky_settings'] != null
        ? new StickySettings.fromJson(json['sticky_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['follow_me_number'] = this.followMeNumber;
    data['eid'] = this.eid;
    data['intercom'] = this.intercom;
    data['calls_answered'] = this.callsAnswered;
    data['calls_missed'] = this.callsMissed;
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['custom_status'] = this.customStatus;
    data['timegroup_name'] = this.timegroupName;
    data['timegroup_id'] = this.timegroupId;
    data['failover_destination'] = this.failoverDestination;
    data['failover_destination_name'] = this.failoverDestinationName;
    data['is_verified'] = this.isVerified;
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    if (this.allowedCallerIds != null) {
      data['allowed_caller_ids'] =
          this.allowedCallerIds!.map((v) => v.toJson()).toList();
    }
    data['agent_cdr'] = this.agentCdr;
    data['associated_agent'] = this.associatedAgent;
    if (this.agentGroups != null) {
      // data['agent_groups'] = this.agentGroups!.map((v) => v.toJson()).toList();
    }
    if (this.stickySettings != null) {
      data['sticky_settings'] = this.stickySettings!.toJson();
    }
    return data;
  }
}

class Departments {
  String? name;
  String? id;

  Departments({this.name, this.id});

  Departments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class AllowedCallerIds {
  String? id;
  String? number;

  AllowedCallerIds({this.id, this.number});

  AllowedCallerIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    return data;
  }
}

class StickySettings {
  Null? timeout;
  Null? ringStrategy;
  List<String>? alternateNumbers;

  StickySettings({this.timeout, this.ringStrategy, this.alternateNumbers});

  StickySettings.fromJson(Map<String, dynamic> json) {
    timeout = json['timeout'];
    ringStrategy = json['ring_strategy'];
    alternateNumbers = json['alternate_numbers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeout'] = this.timeout;
    data['ring_strategy'] = this.ringStrategy;
    data['alternate_numbers'] = this.alternateNumbers;
    return data;
  }
}
