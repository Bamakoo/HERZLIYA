import { Request, Response, Router } from "express";
import {
  list,
  create,
  update,
  del,
  retrieve,
} from "../controllers/usersControllers.ts";

const router = Router();

router.get("/", async (req: Request, res: Response) => {
  const users = await list();
  return res.json(users);
});

router.get("/:id", async (req: Request, res: Response) => {
  const id = req.params.id;
  const datas = await retrieve(id);
  console.log("id :", id, "datas :", datas);
  return res.json(datas);
});

router.post("/", async (req, res) => {
  const datas = await create(req.body);
  return res.json(datas);
});

router.patch("/:id", async (req: Request, res: Response) => {
  const id = req.params.id;
  const datas = await update(id, req.body);
  return res.json(datas);
});

router.delete("/:id", async (req: Request, res: Response) => {
  const id = req.params.id;
  const datas = await del(id);
  return res.json(datas);
});

export { router as userRoutes };
