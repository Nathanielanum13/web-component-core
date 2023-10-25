import { fileURLToPath, URL } from 'node:url'
const fs = require('fs');
const path = require('path');

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

const directoryPath = './src/components';

const subdirectories: any = [];

// Read the directory and find subdirectories
const items = fs.readdirSync(directoryPath);
items.forEach((item: any) => {
  const itemPath = path.join(directoryPath, item);
  if (fs.statSync(itemPath).isDirectory()) {
    subdirectories.push(item);
  }
});

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  build: {
    lib: {
      entry: subdirectories.reduce((entries: any, component:any) => {
        const name = component.replace(/([a-z0-9])([A-Z])/g, '$1-$2').toLowerCase()
        entries[name] = `./src/components/${component}/${component}.js`
        return entries
      }, {}),
      formats: ["es"],
    },
    // rollupOptions: {
    //   // Make sure to externalize Vue if you're using it as a dependency
    //   external: ['vue'],
    //   output: {
    //     globals: {
    //       vue: 'Vue',
    //     },
    //   },
    // },
  },
  define: {
    'process.env': process.env
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
