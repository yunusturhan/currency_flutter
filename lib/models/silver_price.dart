  class SilverPrice {
    bool? success;
    List<Result>? result;

    SilverPrice({this.success, this.result});

    SilverPrice.fromJson(Map<String, dynamic> json) {
      success = json['success'];
      if (json['result'] != null) {
        result = <Result>[];
        json['result'].forEach((v) {
          result!.add(new Result.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['success'] = this.success;
      if (this.result != null) {
        data['result'] = this.result!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class Result {
    String? currency;
    String? buyingstr;
    double? buying;
    String? sellingstr;
    double? selling;
    double? rate;
    String? updatetime;

    Result(
        {this.currency,
          this.buyingstr,
          this.buying,
          this.sellingstr,
          this.selling,
          this.rate,
          this.updatetime});

    Result.fromJson(Map<String, dynamic> json) {
      currency = json['currency'];
      buyingstr = json['buyingstr'];
      buying = json['buying'];
      sellingstr = json['sellingstr'];
      selling = json['selling'];
      rate = json['rate'];
      updatetime = json['updatetime'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['currency'] = this.currency;
      data['buyingstr'] = this.buyingstr;
      data['buying'] = this.buying;
      data['sellingstr'] = this.sellingstr;
      data['selling'] = this.selling;
      data['rate'] = this.rate;
      data['updatetime'] = this.updatetime;
      return data;
    }
  }