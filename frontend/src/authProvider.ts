import { AuthProvider } from 'react-admin';
import axios from 'axios';

const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export const authProvider: AuthProvider = {
  login: async ({ username, password }) => {
    try {
      const response = await axios.post(`${apiUrl}/auth/login`, {
        email: username,
        senha: password,
      });

      const { accessToken, usuario } = response.data;

      localStorage.setItem('token', accessToken);
      localStorage.setItem('user', JSON.stringify(usuario));
      localStorage.setItem('permissions', usuario.grupos[0] || 'usuario_comum');

      return Promise.resolve();
    } catch (error) {
      return Promise.reject(new Error('Email ou senha inválidos'));
    }
  },

  logout: () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    localStorage.removeItem('permissions');
    return Promise.resolve();
  },

  checkAuth: () => {
    return localStorage.getItem('token') ? Promise.resolve() : Promise.reject();
  },

  checkError: (error) => {
    const status = error.status;
    if (status === 401 || status === 403) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      localStorage.removeItem('permissions');
      return Promise.reject();
    }
    return Promise.resolve();
  },

  getIdentity: () => {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return Promise.resolve({
        id: user.id,
        fullName: user.nome,
        avatar: undefined,
      });
    } catch (error) {
      return Promise.reject();
    }
  },

  getPermissions: () => {
    const permissions = localStorage.getItem('permissions');
    return permissions ? Promise.resolve(permissions) : Promise.reject();
  },
};
