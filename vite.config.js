import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
const root = fileURLToPath(new URL('.', import.meta.url))

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@src': path.resolve(root, 'src'),
      '@components': path.resolve(root, 'src/view/components'),
      '@view': path.resolve(root, 'src/view'),
      '@viewModel': path.resolve(root, 'src/viewModel'),
      '@backend': path.resolve(root, 'src/backend'),
      '@model': path.resolve(root, 'src/model'),
    }
  }
})
