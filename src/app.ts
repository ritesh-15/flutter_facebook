import Express from "express";
import errorHandler from "./middleware/errorHandler";
import redisConfig from "./config/redisConfig";
import logger from "./utils/logger";
import configRoutes from "./routes/config.routes";
import configMiddleWares from "./middleware/configMiddlewares";
import PrismaProvider from "./utils/prisma";

const main = async () => {
  const app = Express();

  const PORT = process.env.PORT || 9000;

  app.listen(PORT, async () => {
    logger.info(`Server started on http://localhost:${PORT} 🚀🚀`);

    await PrismaProvider.instance().$connect();
    logger.info("Database connected successfully!");

    redisConfig();
    configMiddleWares(app);
    configRoutes(app);
    app.use(errorHandler);
  });
};

main();
