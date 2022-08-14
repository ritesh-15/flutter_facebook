-- AlterTable
ALTER TABLE "User" ADD COLUMN     "resetExpiry" TIMESTAMP(3),
ADD COLUMN     "resetToken" TEXT;
