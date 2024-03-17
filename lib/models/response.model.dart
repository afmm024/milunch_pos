class Response {
      dynamic data;
      bool status;
      String message;

      Response({
        required this.data,
        required this.status,
        required this.message
      });
      Map<dynamic, dynamic> toJson() {
        return {
          "data": data,
          "status": status,
          "message": message
        };
      }

      factory Response.fromJson(Map<dynamic, dynamic> json) {
        return Response(
          data: json['data'],
          status: json['status'],
          message: json['message']
        );
      }
    }