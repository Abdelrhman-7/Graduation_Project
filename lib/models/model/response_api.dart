class ResponseApi {
  Info? info;
  List<Item>? item;
  List<Variable>? variable;
  String? email;
  int? status;
  String? message;

  ResponseApi({
    this.info,
    this.item,
    this.variable,
    this.email,
    this.status,
    this.message,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;

    if (json['item'] != null) {
      item = List.from(json['item']).map((e) => Item.fromJson(e)).toList();
    }

    if (json['variable'] != null) {
      variable = List.from(
        json['variable'],
      ).map((e) => Variable.fromJson(e)).toList();
    }
    email = json['email'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      "info": info?.toJson(),
      "item": item?.map((e) => e.toJson()).toList(),
      "variable": variable?.map((e) => e.toJson()).toList(),
      "email": email,
      "status": status,
      "message": message,
    };
  }
}

class Info {
  String? postmanId;
  String? name;
  String? description;
  String? schema;
  String? exporterId;

  Info({
    this.postmanId,
    this.name,
    this.description,
    this.schema,
    this.exporterId,
  });

  Info.fromJson(Map<String, dynamic> json) {
    postmanId = json['_postman_id'];
    name = json['name'];
    description = json['description'];
    schema = json['schema'];
    exporterId = json['_exporter_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "_postman_id": postmanId,
      "name": name,
      "description": description,
      "schema": schema,
      "_exporter_id": exporterId,
    };
  }
}

class Item {
  String? name;
  List<Item>? item;
  Request? request;
  List<ApiResponse>? response;

  Item({this.name, this.item, this.request, this.response});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    if (json['item'] != null) {
      item = List.from(json['item']).map((e) => Item.fromJson(e)).toList();
    }

    request = json['request'] != null
        ? Request.fromJson(json['request'])
        : null;

    if (json['response'] != null) {
      response = List.from(
        json['response'],
      ).map((e) => ApiResponse.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "item": item?.map((e) => e.toJson()).toList(),
      "request": request?.toJson(),
      "response": response?.map((e) => e.toJson()).toList(),
    };
  }
}

class Request {
  String? method;
  List<Header>? header;
  Body? body;
  Url? url;
  String? description;

  Request({this.method, this.header, this.body, this.url, this.description});

  Request.fromJson(Map<String, dynamic> json) {
    method = json['method'];

    if (json['header'] != null) {
      header = List.from(
        json['header'],
      ).map((e) => Header.fromJson(e)).toList();
    }

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    url = json['url'] != null ? Url.fromJson(json['url']) : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      "method": method,
      "header": header?.map((e) => e.toJson()).toList(),
      "body": body?.toJson(),
      "url": url?.toJson(),
      "description": description,
    };
  }
}

class ApiResponse {
  String? name;
  OriginalRequest? originalRequest;
  String? status;
  int? code;
  String? postmanPreviewlanguage;
  List<Header>? header;
  List<dynamic>? cookie;
  String? body;

  ApiResponse({
    this.name,
    this.originalRequest,
    this.status,
    this.code,
    this.postmanPreviewlanguage,
    this.header,
    this.cookie,
    this.body,
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    originalRequest = json['originalRequest'] != null
        ? OriginalRequest.fromJson(json['originalRequest'])
        : null;

    status = json['status'];

    code = json['code'] != null ? int.tryParse(json['code'].toString()) : null;

    postmanPreviewlanguage = json['_postman_previewlanguage'];

    if (json['header'] != null) {
      header = List.from(
        json['header'],
      ).map((e) => Header.fromJson(e)).toList();
    }

    cookie = json['cookie'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "originalRequest": originalRequest?.toJson(),
      "status": status,
      "code": code,
      "_postman_previewlanguage": postmanPreviewlanguage,
      "header": header?.map((e) => e.toJson()).toList(),
      "cookie": cookie,
      "body": body,
    };
  }
}

class OriginalRequest {
  String? method;
  List<Header>? header;
  Body? body;
  Url? url;

  OriginalRequest({this.method, this.header, this.body, this.url});

  OriginalRequest.fromJson(Map<String, dynamic> json) {
    method = json['method'];

    if (json['header'] != null) {
      header = List.from(
        json['header'],
      ).map((e) => Header.fromJson(e)).toList();
    }

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    url = json['url'] != null ? Url.fromJson(json['url']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "method": method,
      "header": header?.map((e) => e.toJson()).toList(),
      "body": body?.toJson(),
      "url": url?.toJson(),
    };
  }
}

class Header {
  String? key;
  String? value;

  Header({this.key, this.value});

  Header.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value};
  }
}

class Url {
  String? raw;
  String? protocol;
  List<String>? host;
  List<String>? path;

  Url({this.raw, this.protocol, this.host, this.path});

  Url.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    protocol = json['protocol'];
    host = json['host'] != null ? List<String>.from(json['host']) : [];
    path = json['path'] != null ? List<String>.from(json['path']) : [];
  }

  Map<String, dynamic> toJson() {
    return {"raw": raw, "protocol": protocol, "host": host, "path": path};
  }
}

class Body {
  String? mode;
  String? raw;
  Options? options;

  Body({this.mode, this.raw, this.options});

  Body.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    raw = json['raw'];
    options = json['options'] != null
        ? Options.fromJson(json['options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {"mode": mode, "raw": raw, "options": options?.toJson()};
  }
}

class Options {
  Raw? raw;

  Options({this.raw});

  Options.fromJson(Map<String, dynamic> json) {
    raw = json['raw'] != null ? Raw.fromJson(json['raw']) : null;
  }

  Map<String, dynamic> toJson() {
    return {"raw": raw?.toJson()};
  }
}

class Raw {
  String? language;

  Raw({this.language});

  Raw.fromJson(Map<String, dynamic> json) {
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    return {"language": language};
  }
}

class Variable {
  String? key;
  String? value;
  String? type;
  String? description;

  Variable({this.key, this.value, this.type, this.description});

  Variable.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
      "type": type,
      "description": description,
    };
  }
}
