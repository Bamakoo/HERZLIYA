import logo from './logo.svg';
import './App.css';
import Header from './components/header';
import { useEffect, useState} from 'react';
function App() {
  const [count, setCount] = useState(0); 

  const [characters, setCharacters] = useState([]);



  useEffect(() => {
    fetch('https://rickandmortyapi.com/api/character/')
      .then(response => response.json())
      .then(data => {
        setCharacters(data.results);
      })
  }, []);

  console.log(characters);
  //console.log(count)
  return (
    <div className="App">
      <Header/>
      <button onClick={() => setCount(count + 1)}>Click Me</button>
    </div>
  );
}

export default App;