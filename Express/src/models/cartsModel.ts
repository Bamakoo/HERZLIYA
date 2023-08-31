import type { Users } from "./usersModel";
import type { Books } from "./booksModel";

export interface Cart {
  id: string;
  user_id: Users["id"];
  books: Books["id"][];
  total: number;
  createdAt: number;
  purchasedAt: number | null;
  updatedAt: number | null;
  deletedAt: number | null;
}
