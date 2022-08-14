import UserInterface from "../interfaces/UserInterface";

export {};

declare global {
  namespace Express {
    interface Request {
      user: UserInterface | null;
    }
  }
}
