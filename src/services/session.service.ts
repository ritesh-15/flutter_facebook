import PrismaProvider from "../utils/prisma";

class SessionService {
  static findSession(query: { token?: string; id?: string }) {
    return PrismaProvider.instance().session.findFirst({
      where: query,
      include: {
        user: {
          select: {
            id: true,
          },
        },
      },
    });
  }

  static createSession(data: { userId: string; token: string }) {
    return PrismaProvider.instance().session.create({
      data: data,
    });
  }

  static deleteSession(query: { id?: string }) {
    return PrismaProvider.instance().session.delete({
      where: query,
    });
  }

  static deleteAllSessions(userId: string) {
    return PrismaProvider.instance().session.deleteMany({
      where: {
        userId,
      },
    });
  }
}

export default SessionService;
