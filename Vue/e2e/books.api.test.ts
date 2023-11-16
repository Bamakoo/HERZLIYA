import { test, expect } from '@playwright/test'

test.describe.parallel('BOOKS API TESTING', () => {
  const BASE_URL = 'http://127.0.0.1:8080'
  const FRONT_URL = 'http://localhost:5173'
  test('GET - Books list', async ({ request }) => {
    const response = await request.get(`${BASE_URL}/books`)
    expect(response.status()).toBe(200)
  })

  test('GET - One book', async ({ request }) => {
    const bookID = '8c2d43f0-a5a0-425e-8cb9-543266b9cfc3'
    const response = await request.get(`${BASE_URL}/books/${bookID}`)
    expect(response.status()).toBe(200)
    expect(response.body()).toBeTruthy()
  })

  test('GET - One book fails', async ({ request }) => {
    const response = await request.get(`${BASE_URL}/books/123456`)
    expect(response.status()).toBe(404)
  })

  const bookData = {
    title: 'Playwright Book',
    author: 'Playwrigt',
    genre: 'nonFiction',
    price: 124,
    state: 'good',
    description: 'Test playwright create book ! 🧪'
  }

  test('POST - Create a book without token', async ({ request }) => {
    const response = await request.post(`${BASE_URL}/books`, {
      data: bookData,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': FRONT_URL,
        Accept: 'application/json'
      }
    })
    const body = JSON.parse(await response.text())
    console.log(body)

    expect(response.status()).toBe(401)
  })

  test('POST - Create a book with token', async ({ request }) => {
    const response = await request.post(`${BASE_URL}/books`, {
      data: bookData,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': FRONT_URL,
        Accept: 'application/json',
        Authorization: 'Bearer Hh4/SNvn0l/NK/nPIVP6Xw=='
      }
    })
    expect(response.status()).toBe(200)
    const body = JSON.parse(await response.text())
    expect(body.data.author).toBe('Playwrigt')
  })
})
