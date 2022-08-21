import logger from "../utils/logger";
import RedisClient from "../utils/redis";

const redisConfig = async () => {
  try {
    await RedisClient.instance().connect();
    RedisClient.instance().on("error", (err) => logger.error(err));
    logger.info("Redis client connected!");
  } catch (error) {
    logger.error(error);
  }
};

export default redisConfig;
