import RedisClient from "../utils/redis";

const redisConfig = async () => {
  await RedisClient.instance().connect();

  RedisClient.instance().on("error", (err) =>
    console.log("Redis error occurred!")
  );

  console.log("Redis client connected!");
};

export default redisConfig;
