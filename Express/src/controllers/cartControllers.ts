import carts from "../datas/carts.json" assert { type: "json" };
import type { Cart } from "../models/cartsModel.ts";

export const list = () => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = carts;
      resolve(datas);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const retrieve = (id: Cart["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = carts;
      const book = datas.find((el) => el.id === id);
      resolve(book);
      return book;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

// export const create = (data: Cart) => {
//   const result = new Promise((resolve) => {
//     try {
//       const { datas } = carts;
//       const cartData: Cart = {
//         ...data,
//         purchasedAt: null,
//         updatedAt: null,
//         deletedAt: null,
//       };
//       datas.push(cartData);
//       resolve(datas);
//     } catch (error) {
//       throw new Error((error as Error).message);
//     }
//   });
//   return result;
// };

export const update = (id: Cart["id"], data: Cart) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = carts;
      const foundIndex = datas.findIndex((el) => el.id === id);

      if (foundIndex === -1) throw new Error("L'id ne correspond pas");

      //datas[foundIndex].books = data.books ?? datas[foundIndex].books; //update livres (toujours dispo, supprimé du panier)
      //CALCUL DU TOTAL : datas.total = datas.reduce(book => book.price)
      resolve(datas[foundIndex]);
      return datas;
    } catch (error) {
      throw new Error((error as Error).message);
    }
  });
  return result;
};

export const del = async (id: Cart["id"]) => {
  const result = new Promise((resolve) => {
    try {
      const { datas } = carts;
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
