import { Request, Response, Router } from "express";
import { list } from "../controllers/usersControllers.ts";
// import { login } from "@/controllers/loginController.ts";

const router = Router();

router.post("/", async (req: Request, res: Response) => {
  let auth = req.headers.authorization;

  const token = Buffer.from(auth ?? "", "base64");
  console.log(token);
  const [username, password] = auth?.split(":") ?? [];
  const users = await list();
  const match = users.find(
    (user) => user.username === username && user.password === password
  );
  // if (!match) res.sendStatus(401);

  if (match) {
    let BufferStringify = match.token.toString();
    BufferStringify = token.toString(); //atob(auth ?? "");
    return BufferStringify;
  }
  res.header("Authorization", `Basic ${token}`);
  res.status(200);
  // console.log((auth = ));
  return token;
});

router.delete("/", async (req, res) => {
  res.header("Autorization");
});

export { router as loginRoutes };
