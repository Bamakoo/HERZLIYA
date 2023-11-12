import { test, expect } from '@playwright/test'
import AxeBuilder from '@axe-core/playwright' // 1

const TestLogintPage = async () => {
  test.describe('loginpage', () => {
    // 2
    test('should not have any automatically detectable accessibility issues', async ({ page }) => {
      await page.goto('/login') // 3

      const accessibilityScanResults = await new AxeBuilder({ page }).analyze() // 4
      new AxeBuilder({ page }).include('button')
      expect(accessibilityScanResults.violations).toEqual([]) // 5
    })
  })
}

TestLogintPage()
