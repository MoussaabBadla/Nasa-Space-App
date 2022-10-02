import User from "../models/User.js";
export async function getUser(req, res) {
  try {

    const user = req.user;
    user._doc.password = undefined;
    console.log(user);
    return res.status(200).json({ success: true, data: { ...user._doc } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
}
export async function addtofavorite(req,res){
  try {
     let  articlid =  req.params.id;
   let user = req.user

    
      user.favorite.push(articlid) 
      user = await user.save();

      return res.status(200).json({ success: true, data: { ...user._doc } });
    

    
   

  } catch (e) {
    res.status(404).json({ success: false, message: 'Failed' });
    console.log(e);

    
  }
}
export async function deletfromfavorite(req,res){
  try {
     let  articlid =  req.params.id;
     
   let user = req.user

    console.log(articlid);

     user.favorite = user.favorite.filter( el => el != articlid)
      user = await user.save();
      return res.status(200).json({ success: true, data: {...user._doc
      } });

    
   

  } catch (e) {
    res.status(344).json({ success: false, message: 'Failed' });

    
  }
}
