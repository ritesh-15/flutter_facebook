const extractPublicIdFromUrl = (url: string) =>
  url.split("/").reverse().slice(0, 2)[0].split(".").splice(0)[0];

export default extractPublicIdFromUrl;
