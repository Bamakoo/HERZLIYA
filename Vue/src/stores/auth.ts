import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    isAuthenticated: false
  }),
  actions: {
    login() {
      // Effectuer l'appel à l'API pour la connexion avec votre service d'authentification
      // et mettez à jour isAuthenticated en cas de succès.
      this.isAuthenticated = true
    },
    logout() {
      // Effectuer l'appel à l'API pour la déconnexion
      // et mettez à jour isAuthenticated en cas de succès.
      this.isAuthenticated = false
    }
  }
})
