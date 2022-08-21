import multer from "multer";
import path from "path";
import { v4 as uuidV4 } from "uuid";

const options: multer.DiskStorageOptions = {
  destination: (req, file, cb) => {
    const destination = path.join(__dirname, "../../public/uploads");
    cb(null, destination);
  },
  filename: (req, file, cb) => {
    const filename = `${Date.now()}_${uuidV4()}${path.extname(
      file.originalname
    )}`;
    cb(null, filename);
  },
};

const storage = multer.diskStorage(options);

const uploadImage = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const regx = /^(image)\/(jpeg|png|jpg)$/;
    if (regx.test(file.mimetype)) {
      cb(null, true);
    }
    cb(null, false);
  },
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB File Size
  },
});

export default uploadImage;