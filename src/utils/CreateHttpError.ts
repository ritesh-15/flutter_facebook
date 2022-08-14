class CreateHttpError {
  status: number;
  message: string;
  error: string;

  constructor(status: number, message: string, error: string) {
    this.status = status;
    this.message = message;
    this.error = error;
  }

  static badRequest(message: string = "Bad request!") {
    return new CreateHttpError(400, message, "Bad request!");
  }

  static unauthorized(message: string = "Unauthorized!") {
    return new CreateHttpError(401, message, "Unauthorized!");
  }

  static forbidden(message: string = "Forbidden!") {
    return new CreateHttpError(403, message, "Forbidden!");
  }

  static notFound(message: string = "Not found!") {
    return new CreateHttpError(404, message, "Not found!");
  }

  static internalServerError(message: string = "Internal server error!") {
    return new CreateHttpError(500, message, "Internal server error!");
  }

  static notImplemented(message: string = "Not implemented!") {
    return new CreateHttpError(501, message, "Not implemented!");
  }

  static unprocessableEntity(message: string = "Unprocessable entity!") {
    return new CreateHttpError(422, message, "Unprocessable entity!");
  }
}

export default CreateHttpError;