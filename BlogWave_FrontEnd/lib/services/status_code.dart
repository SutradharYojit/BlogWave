// This class defines constants for common HTTP status codes
class ServerStatusCodes {
  static const int success = 200;              // HTTP 200 OK
  static const int addSuccess = 201;           // HTTP 201 Created
  static const int intervalServerError = 500;  // HTTP 500 Internal Server Error
  static const int unAuthorised = 401;         // HTTP 401 Unauthorized
  static const int pageNotFound = 404;         // HTTP 404 Not Found
  static const int timeOut = 504;              // HTTP 504 Gateway Timeout
  static const int serverError = 500;          // HTTP 500 Internal Server Error
  static const int badRequest = 400;           // HTTP 400 Bad Request
  static const int forBid = 403;               // HTTP 403 Forbidden
}