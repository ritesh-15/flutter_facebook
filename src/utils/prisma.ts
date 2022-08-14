import { PrismaClient } from "@prisma/client";

class PrismaProvider {
  static prisma: PrismaClient | null = null;

  static instance(): PrismaClient {
    if (PrismaProvider.prisma === null) {
      PrismaProvider.prisma = new PrismaClient();
      return PrismaProvider.prisma;
    }

    return PrismaProvider.prisma;
  }
}

export default PrismaProvider;
