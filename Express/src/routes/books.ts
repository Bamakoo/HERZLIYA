import { Request, Response, Router } from "express";
import {
  list,
  create,
  update,
  del,
  retrieve,
} from "../controllers/booksController.ts";

const router = Router();

router.get("/", async (req: Request, res: Response) => {
  const books = await list();
  return res.json(books);
});

router.get("/:id", async (req: Request, res: Response) => {
  const id = req.params.id;
  const datas = await retrieve(id);
  return res.json(datas);
});

router.post("/", async (req, res) => {
  const datas = await create(req.body);
  return res.json(datas);
});
router.post("/:id/add-to-kart", async (req, res) => {
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

router.delete("/:id/remove-from-kart", async (req: Request, res: Response) => {
  const id = req.params.id;
  const datas = await del(id);
  return res.json(datas);
});

export { router as booksRoutes };
