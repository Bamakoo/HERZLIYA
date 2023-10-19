import books from "../datas/books.json" assert { type: "json" };
import type { Books } from "../models/booksModel.ts";

export const list = () => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = books;
      resolve(datas);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const retrieve = (id: Books["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = books;
      const book = datas.find((el) => el.id === id);
      resolve(book);
      return book;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const create = (data: Books, id?: string) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = books;
      datas.push(data);
      resolve(datas);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const update = (id: Books["id"], data: Books) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = books;
      const foundIndex = datas.findIndex((el) => el.id === id);

      if (foundIndex === -1) throw new Error("L'id ne correspond pas");

      datas[foundIndex].title = data.title ?? datas[foundIndex].title;
      datas[foundIndex].author = data.author ?? datas[foundIndex].author;
      datas[foundIndex].price = data.price ?? datas[foundIndex].price;
      datas[foundIndex].state = data.state ?? datas[foundIndex].state;

      resolve(datas[foundIndex]);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const del = async (id: Books["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = books;
      datas.find((el) => {
        if (el.id === id) {
          const index = datas.indexOf(el);
          datas.splice(index, 1);
          return datas;
        }
      });
      resolve(datas);
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};
