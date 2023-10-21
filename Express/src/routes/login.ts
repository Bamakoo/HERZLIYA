import { Request, Response, Router } from "express";
import { list } from "../controllers/usersControllers.ts";
// import { login } from "@/controllers/loginController.ts";

const router = Router();

router.post("/", async (req: Request, res: Response) => {
  let auth = req.headers.authorization ?? "";

  const decode = Buffer.from(auth, "base64").toString("utf-8");
  console.log("decode", decode);
  const token = auth?.split(" ") ?? [];
  console.log("token :", token);
  // const users = await list();
  // const match = users.find((user) => user.token === token[1]);
  // if (!match) res.sendStatus(401);

  // if (match) {
  //   let BufferStringify = match.decode.toString();
  //   let BufferStringify = atob(auth ?? ""); //decode.toString(); //
  //   return BufferStringify;
  // }
  res.header("Authorization", `Basic ${token}`);
  res.status(200);
  // console.log((auth = ));
  new Promise((resolve) => {
    setTimeout(() => {
      resolve("okay");
      return "YXVkcmV5Om1kcA==";
    }, 300);
  });
  return "YXVkcmV5Om1kcA==";
});

router.delete("/", async (req, res) => {
  res.header("Autorization");
});

export { router as loginRoutes };
