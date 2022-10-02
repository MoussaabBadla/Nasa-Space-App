
import mongoose from "mongoose";

const uri = process.env.MONGO_URI;
const connectDB = (cb) => {

  mongoose.connect(uri, 
    {
      useUnifiedTopology: true, 

      useNewUrlParser: true })
  .then((client) => {
      console.log("connected to mongoDB");
      return cb();
    })
    .catch((err) => {
      console.log(err);
      return cb(err);
    });
};

export default connectDB;
