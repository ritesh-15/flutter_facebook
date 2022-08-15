import multer from "multer";
import path from "path";
import { v4 as uuidV4 } from "uuid";

const options: multer.DiskStorageOptions = {
  destination: (req, file, cb) => {
    const destination = path.resolve("../../public/uploads");
    cb(null, destination);
  },
  filename: (req, file, cb) => {
    const filename = `${uuidV4()}.${path.extname(file.originalname)}`;
    cb(null, filename);
  },
};

const storage = multer.diskStorage(options);

const uploadImage = multer({ storage });

export default uploadImage;
