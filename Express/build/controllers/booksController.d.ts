import type { Books } from "../models/booksModel.ts";
export declare const list: () => Promise<unknown>;
export declare const retrieve: (id: Books["id"]) => Promise<unknown>;
export declare const create: (data: Books) => Promise<unknown>;
export declare const update: (id: Books["id"], data: Books) => Promise<unknown>;
export declare const del: (id: Books["id"]) => Promise<unknown>;
