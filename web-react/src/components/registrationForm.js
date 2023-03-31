import React, {useState,setState} from 'react';
import './style.css'
import { createUser } from '../services/userService'

function RegistrationForm() {
    const [username, setUserName] = useState(null);
    const [email, setEmail] = useState(null);
    const [password,setPassword] = useState(null);
    const [confirmPassword,setConfirmPassword] = useState(null);
    const [favoriteBook, setFavoriteBook] = useState(null); 
    const [favoriteAuthor, setFavoriteAuthor] = useState(null); 
    const [city, setCity] = useState(null); 
    const [country, setCountry] = useState(null); 

    const handleInputChange = (e) => {
        const {id , value} = e.target;
        if(id === "username"){
            setUserName(value);
        }
        if(id === "email"){
            setEmail(value);
        }
        if(id === "password"){
            setPassword(value);
        }
        if(id === "confirmPassword"){
            setConfirmPassword(value);
        }
        if(id === "favoriteBook"){
            setFavoriteBook(value);
        }
        if(id === "favoriteAuthor"){
            setFavoriteAuthor(value);
        }
        if(id === "city"){
            setCity(value);
        }
        if(id === "country"){
            setCountry(value);
        }
    }

    const handleSubmit  = (e) => {
        console.log(username,email,password,confirmPassword,favoriteBook,favoriteAuthor,city,country);

      createUser({name : username, email : email, password : password, favoriteBook : favoriteBook, favoriteAuthor : favoriteAuthor, city : city, country : country})
      .then(response => {
        console.log(response);
    
    });
    }


    return(
        <div className="form">
            <div className="form-body">
                <div className="username">
                    <label className="form__label" for="username">User Name </label>
                    <input className="form__input" type="text" id="username" value={username} onChange = {(e) => handleInputChange(e)} placeholder="User Name"/>
                </div>
                <div className="email">
                    <label className="form__label" for="email">Email </label>
                    <input className="form__input" type="email" id="email" value={email} onChange = {(e) => handleInputChange(e)} placeholder="Email"/>
                </div>
                <div className="password">
                    <label className="form__label" for="password">Password </label>
                    <input className="form__input" type="password"  id="password" value={password} onChange = {(e) => handleInputChange(e)} placeholder="Password"/>
                </div>
                <div className="confirm-password">
                    <label className="form__label" for="confirmPassword">Confirm Password </label>
                    <input className="form__input" type="password" id="confirmPassword" value={confirmPassword} onChange = {(e) => handleInputChange(e)} placeholder="Confirm Password"/>
                </div>
                <div className="favoriteBook">
                    <label className="form__label" for="favoriteBook">Favorite Book </label>
                    <input className="form__input" type="text" name="" id="favoriteBook" value={favoriteBook} onChange = {(e) => handleInputChange(e)} placeholder="Favorite Book"/>
                </div>
                <div className="favoriteAuthor">
                    <label className="form__label" for="favoriteAuthor">Favorite Author </label>
                    <input className="form__input" type="text" name="" id="favoriteAuthor" value={favoriteAuthor} onChange = {(e) => handleInputChange(e)} placeholder="Favorite Author"/>
                </div>
                <div className="city">
                    <label className="form__label" for="city">City </label>
                    <input className="form__input" type="text" name="" id="city" value={city} onChange = {(e) => handleInputChange(e)} placeholder="City"/>
                </div>
                <div className="country">
                    <label className="form__label" for="country">Country </label>
                    <input className="form__input" type="text" name="" id="country" value={country} onChange = {(e) => handleInputChange(e)} placeholder="Country"/>
                </div>
            </div>
            <div class="footer">
                <button onClick={(e)=>handleSubmit()} type="submit" class="btn">Register</button>
            </div>
        </div>
       
    )       
}
export default RegistrationForm;