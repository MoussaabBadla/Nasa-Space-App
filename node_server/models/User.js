import mongoose from "mongoose"
const COLLECTION_NAME = 'users';
const DOCUMENT_NAME = 'User';

const userschema = new mongoose.Schema({

    

    username: {
        type: String,
        required: true,
        trim : true 
        
    },
    email: {
        type: String,
        required: true,
        unique:true,
        
              trim : true,
        validate : {
            validator : (value ) => {
                const re =   /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
             return value.match (re);
            }, 
            message : 'Please enter a valid email address'

        }
    },
    password: {
        type: String ,
        required: true,
        validate : {
            validator : (value ) => {
              return   value.length >= 6 
            }, 
            message : 'The password is too short'

        }

    },
    favorite : {
        type : [String], 
        default : [] 
    },
    phone:{
        type : String  , 
        default : ""
    
      /*  validate : { 
            validator :   (value) => {
                        const si = /^\d{10}$/ 
                        return value.match(si)

        },
        message : 'Please enter a valid phone number'},*/
    }
}


)

export default mongoose.model(DOCUMENT_NAME, userschema, COLLECTION_NAME)