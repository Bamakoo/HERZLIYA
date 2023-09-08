import express, { Express, Request, Response, urlencoded } from "express";
import dotenv from "dotenv";
import { booksRoutes } from "./routes/books.ts";
import { userRoutes } from "./routes/users.ts";
import { cartRoutes } from "./routes/carts.ts";
import { loginRoutes } from "./routes/login.ts";
import cors from "cors";

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 3001;

app.get("/", (req: Request, res: Response) => {
  res.send("Express + TypeScript Server");
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});

app.use(express.json());
app.use(urlencoded({ extended: true }));
app.use(
  cors({
    origin: "http://localhost:5173", //process.env.VUE ?? process.env.HOST, //"http://192.168.1.17:5173/",
    allowedHeaders: [
      "Content-Type",
      "Accept",
      "Access-Control-Allow-Origin",
      "Authorization",
    ],
    methods: "GET, POST, PATCH, DELETE",
    credentials: true,
  })
);

app.use("/books", booksRoutes);
app.use("/users", userRoutes);
app.use("/cart", cartRoutes);
app.use("/login", loginRoutes);
