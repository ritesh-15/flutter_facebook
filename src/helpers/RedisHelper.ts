import RedisClient from "../utils/redis";

class RedisHelper {
  static USER = "user";

  static get(key: string): Promise<any> {
    return RedisClient.instance().get(key);
  }

  static set(key: string, value: string): Promise<any> {
    return RedisClient.instance().set(key, value);
  }

  static remove(key: string): Promise<any> {
    return RedisClient.instance().del(key);
  }
}

export default RedisHelper;
