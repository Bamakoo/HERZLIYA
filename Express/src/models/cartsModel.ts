import type { Users } from "./usersModel";
import type { Books } from "./booksModel";

export interface Cart {
  id: string;
  user_id: Users["id"];
  books: Books[];
  total: number;
  createdAt: number;
  purchasedAt: number;
  updatedAt: number;
  deletedAt: number;
}
