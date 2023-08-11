// //fetch POST, GET, PATH, DELETE

// //create
// const post = async (url: string, body: BodyInit | null | undefined) => {
//   const datas = await fetch(url, {
//     method: 'POST',
//     keepalive: true,
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: JSON.stringify(body)
//   })
//   return datas
// }

// //read
// const get = async (url: string, ...params: unknown[]) => {
//   const datas = await fetch(url, {
//     method: 'GET',
//     headers: { Authentication: 'Bearer Token' }
//   })
//   return datas
// }
// //read w/ autorizations

// //update
// const update = async (url: string, body: BodyInit | null | undefined) => {
//   const datas = await fetch(url, {
//     method: 'PATCH',
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: JSON.stringify(body)
//   })
//   return datas
// }

// //delete
// const del = async (url: string, id: string) => {
//   const datas = await fetch(url, { method: 'DELETE', body: id })
//   return datas
// }

// export default { post, get, update, del }
