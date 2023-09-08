import users from "../datas/users.json" assert { type: "json" };
import { createId } from "@paralleldrive/cuid2";
import type { Users } from "../models/usersModel.ts";

export const list = (): Promise<Users[]> => {
  const result = new Promise<Users[]>((resolve) => {
    try {
      const datas = users.datas as Users[];
      resolve(datas);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const retrieve = (id: Users["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = users;
      const user = datas.find((el) => el.id === id);
      resolve(user);
      return user;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const create = (data: Users) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = users;
      datas.push({ ...data, id: createId(), token: createId() });
      resolve(datas);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const update = (id: Users["id"], data: Users) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = users;
      const foundIndex = datas.findIndex((el) => el.id === id);

      if (foundIndex === -1) throw new Error("L'id ne correspond pas");

      // datas[foundIndex].token = data.token ?? datas[foundIndex].token;
      datas[foundIndex].username = data.username ?? datas[foundIndex].username;
      datas[foundIndex].email = data.email ?? datas[foundIndex].email;
      datas[foundIndex].city = data.city ?? datas[foundIndex].city;
      datas[foundIndex].country = data.country ?? datas[foundIndex].country;
      datas[foundIndex].password = data.password ?? datas[foundIndex].password;
      datas[foundIndex].confirmPassword =
        data.confirmPassword ?? datas[foundIndex].confirmPassword;
      datas[foundIndex].favoriteBook =
        data.favoriteBook ?? datas[foundIndex].favoriteBook;
      datas[foundIndex].favoriteAuthor =
        data.favoriteAuthor ?? datas[foundIndex].favoriteAuthor;
      datas[foundIndex].updatedAt =
        data.updatedAt ?? datas[foundIndex].updatedAt;
      // datas[foundIndex].books = data.books ?? datas[foundIndex].books;
      // datas[foundIndex].purchases =
      //   data.purchases ?? datas[foundIndex].purchases;
      // datas[foundIndex].sales = data.sales ?? datas[foundIndex].sales;
      // datas[foundIndex].friends = data.friends ?? datas[foundIndex].friends;

      resolve(datas[foundIndex]);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const del = async (id: Users["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = users;
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
