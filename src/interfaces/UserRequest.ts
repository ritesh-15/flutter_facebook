import { Request } from "express";

interface UserRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

export default UserRequest;
