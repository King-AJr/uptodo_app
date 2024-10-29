class FocusResponse {
  final bool? success;
  final List<FocusMode>? focus;

  FocusResponse({this.success, this.focus});

  FocusResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        focus = (json['data'] as List?)
            ?.map((dynamic e) => FocusMode.fromJson(e as Map<String, dynamic>))
            .toList();
}

class FocusMode {
  final String day;
  final String? dow;
  final double hours;

  FocusMode( {this.dow,required this.day, required this.hours});

  factory FocusMode.fromJson(Map<String, dynamic> json) {
    return FocusMode(
      day: json['day'],
      dow: json['dow'],
      hours: json['hours'].toDouble(),
    );
  }

  // Method to convert a FocusMode object to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'hours': hours,
    };
  }
}
