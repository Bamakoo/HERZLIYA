import type { Books } from "./booksModel";
import type { Cart } from "./cartsModel";
// import type { Comments } from './comments'
// import type { Likes } from './likes'

export interface Purchases {
  id: string;
  books: Books[];
  seller: Users["id"];
  date: Date | number | string;
}

export interface Sales {
  id: string;
  books: Books[];
  buyer: Users["id"];
  date: Date | number | string;
}

export interface Users {
  id: string;
  token: string;
  username: string;
  email: string;
  city: string;
  country: string;
  password: string;
  confirmPassword: string;
  favoriteBook: string;
  favoriteAuthor: string;
  createdAt: number;
  updatedAt: number;
  books: Books["id"][];
  cart: Cart["books"][];
  purchases: Purchases["id"][];
  sales: Sales["id"][];
  friends: Friends["userId"][];
  // likes: Likes[]
  // comments: Comments[]
}

export interface Friends {
  userId: string;
  friendsId: Users["id"][];
}
