import { Prisma } from "@prisma/client";
import PrismaProvider from "../utils/prisma";

class PostService {
  createNewPost(data: Prisma.PostUncheckedCreateInput) {
    return PrismaProvider.instance().post.create({
      data,
    });
  }

  getAllPosts(query: {
    where?: Prisma.PostWhereInput;
    select?: Prisma.PostSelect;
    include?: Prisma.PostInclude;
    orderBy?: Prisma.Enumerable<Prisma.PostOrderByWithRelationInput>;
  }) {
    const { where, select } = query;

    return PrismaProvider.instance().post.findMany({
      where,
      select,
    });
  }

  deletePostById(id: string) {
    return PrismaProvider.instance().post.delete({
      where: { id },
    });
  }

  findById(id: string) {
    return PrismaProvider.instance().post.findUnique({
      where: {
        id,
      },
    });
  }
}

export default new PostService();
