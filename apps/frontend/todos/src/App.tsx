import { useEffect, useState } from "react";
import "./App.css";
import reactLogo from "./assets/react.svg";
import { DefaultApi } from "./libs/api-clients/generated";
import viteLogo from "/vite.svg";

function App() {
  const [count, setCount] = useState(0);
  const [responseText, setResponseText] = useState("");
  const host = window.location.host;

  useEffect(() => {
    async function fetchData() {
      const api = new DefaultApi();
      const response = await api.getRootGet();
      console.log({ response });
      if (count) {
        setResponseText(response);
      }
    }

    fetchData();
  }, [count, host]);

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
      <p>Response: {responseText}</p>
      <p>Host: {host}</p>
    </>
  );
}

export default App;
