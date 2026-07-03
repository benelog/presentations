import { defineShikiSetup } from '@slidev/types'

// Dark code blocks on the light canvas, matching the former Marp theme.
export default defineShikiSetup(() => {
  return {
    themes: {
      dark: 'one-dark-pro',
      light: 'one-dark-pro',
    },
  }
})
