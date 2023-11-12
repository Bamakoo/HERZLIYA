import { test, expect } from '@playwright/test'

// See here how to get started:
// https://playwright.dev/docs/intro
test('oneH1', async ({ page }) => {
  await page.goto('/')
  const h1 = await page.locator('h1').count()

  if (h1 !== 1) console.log(`Il y a plusieurs h1 sur la page.`)
  console.log('Il y a bien un seul h1 sur la page ! 🎉')
})
