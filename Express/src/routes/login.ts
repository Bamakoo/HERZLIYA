import { Request, Response, Router } from "express";
import { list } from "../controllers/usersControllers.ts";
// import { login } from "@/controllers/loginController.ts";

const router = Router();

router.post("/", async (req: Request, res: Response) => {
  let auth = req.headers.authorization;
  //decode token

  const token = atob(auth ?? "");
  console.log(token);
  //déconstruit
  const [username, password] = auth?.split(":") ?? [];
  const users = await list();
  const match = users.find(
    (user) => user.username === username && user.password === password
  );
  // if (!match) res.sendStatus(401);

  if (match) match.token = token;
  res.header("Authorization", `Basic ${token}`);
  // console.log((auth = ));
  return token;
});

export { router as loginRoutes };
