import mongoose from "mongoose";
const DOCUMENT_NAME = "token";
const COLLECTION_NAME = "tokens";

const tokensSchema = new mongoose.Schema({
  id: {
    type: String,
    required: true,
  },
  tokens: {
    type: [String],
    required: true,
  },
});

export default mongoose.model(DOCUMENT_NAME, tokensSchema, COLLECTION_NAME);
