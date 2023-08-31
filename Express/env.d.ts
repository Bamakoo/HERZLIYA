declare global {
  namespace NodeJS {
    interface ProcessEnv {
      [key: string]: string | undefined;
      PORT: string;
      DATABASE_URL: string;
      VITE_DEV: string;
      VITE_HOST: string;
    }
  }
}
