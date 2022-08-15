import UserInterface from "../interfaces/UserInterface";
import PrismaProvider from "../utils/prisma";

interface SelectOptions {
  id?: boolean;
  firstName?: boolean;
  lastName?: boolean;
  email?: boolean;
  avatar?: boolean;
  cover?: boolean;
  password?: boolean;
  isVerified?: boolean;
  isActivated?: boolean;
  bio?: boolean;
  createdAt?: boolean;
  updatedAt?: boolean;
  resetToken?: boolean;
  resetExpiry?: boolean;
}

interface QueryInterface {
  id?: string;
  email?: string;
}

class UserService {
  static SelectOptions: SelectOptions = {
    id: true,
    firstName: true,
    lastName: true,
    email: true,
    avatar: true,
    cover: true,
    bio: true,
    isVerified: true,
    isActivated: true,
    password: false,
    createdAt: false,
    resetExpiry: false,
    resetToken: false,
  };

  static findUnique = (
    query: QueryInterface,
    selectOptions: SelectOptions = this.SelectOptions
  ): any => {
    return PrismaProvider.instance().user.findUnique({
      where: query,
      select: {
        ...selectOptions,
      },
    });
  };

  static create = (email: string): any => {
    return PrismaProvider.instance().user.create({
      data: { email },
    });
  };

  static deleteOne = (id: string) => {
    return PrismaProvider.instance().user.delete({
      where: {
        id,
      },
    });
  };

  static update = (
    query: QueryInterface,
    data: UserInterface,
    select = this.SelectOptions
  ) => {
    return PrismaProvider.instance().user.update({
      where: query,
      data: data,
      select: select,
    });
  };

  private static findAllUsersOptionsDefault = {
    skip: 1,
    take: 10,
    select: this.SelectOptions,
    filter: {},
  };

  static findAllUsers = (
    data: {
      skip?: number;
      take?: number;
      select?: any;
      filter?: any;
    } = this.findAllUsersOptionsDefault
  ) => {
    const { select, skip, take, filter } = {
      ...this.findAllUsersOptionsDefault,
      ...data,
    };

    return PrismaProvider.instance().user.findMany({
      where: filter,
      select: {
        ...select,
      },
      take: take,
      skip: skip,
    });
  };
}

export default UserService;
