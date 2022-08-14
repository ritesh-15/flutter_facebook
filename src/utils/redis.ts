import { createClient, RedisClientType } from "redis";

class RedisClient {
  static client?: RedisClientType | null = null;

  static instance(): RedisClientType {
    if (RedisClient.client !== null) return RedisClient.client!!;

    RedisClient.client = createClient();
    return RedisClient.client;
  }
}

export default RedisClient;
