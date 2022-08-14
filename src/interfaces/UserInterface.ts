export default interface UserInterface {
  id?: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  avatar?: string;
  cover?: string;
  password?: string;
  isVerified?: boolean;
  isActivated?: boolean;
  bio?: string;
  createdAt?: Date;
  updatedAt?: Date;
  resetToken?: string;
  resetExpiry?: Date;
}
