import { fetchUtils, DataProvider } from 'react-admin';
import queryString from 'query-string';

const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000';

const httpClient = (url: string, options: any = {}) => {
  if (!options.headers) {
    options.headers = new Headers({ Accept: 'application/json' });
  }
  const token = localStorage.getItem('token');
  if (token) {
    options.headers.set('Authorization', `Bearer ${token}`);
  }
  return fetchUtils.fetchJson(url, options);
};

export const dataProvider: DataProvider = {
  getList: (resource, params) => {
    const { page, perPage } = params.pagination;
    const { field, order } = params.sort;
    const query = {
      ...fetchUtils.flattenObject(params.filter),
      _sort: field,
      _order: order,
      _start: (page - 1) * perPage,
      _end: page * perPage,
    };
    const url = `${apiUrl}/${resource}?${queryString.stringify(query)}`;

    return httpClient(url).then(({ headers, json }) => {
      // Se o backend não retornar X-Total-Count, usa o tamanho do array
      const total = headers.has('x-total-count')
        ? parseInt(headers.get('x-total-count')!.split('/').pop()!, 10)
        : json.length;

      return {
        data: json,
        total: total,
      };
    });
  },

  getOne: (resource, params) =>
    httpClient(`${apiUrl}/${resource}/${params.id}`).then(({ json }) => {
      // Para usuários, converter grupos para grupoIds no getOne
      if (resource === 'usuarios' && json.grupos) {
        json.grupoIds = json.grupos.map((g: any) => g.id);
      }
      return {
        data: json,
      };
    }),

  getMany: (resource, params) => {
    const query = {
      id: params.ids,
    };
    const url = `${apiUrl}/${resource}?${queryString.stringify(query)}`;
    return httpClient(url).then(({ json }) => ({ data: json }));
  },

  getManyReference: (resource, params) => {
    const { page, perPage } = params.pagination;
    const { field, order } = params.sort;
    const query = {
      ...fetchUtils.flattenObject(params.filter),
      [params.target]: params.id,
      _sort: field,
      _order: order,
      _start: (page - 1) * perPage,
      _end: page * perPage,
    };
    const url = `${apiUrl}/${resource}?${queryString.stringify(query)}`;

    return httpClient(url).then(({ headers, json }) => {
      const total = headers.has('x-total-count')
        ? parseInt(headers.get('x-total-count')!.split('/').pop()!, 10)
        : json.length;

      return {
        data: json,
        total: total,
      };
    });
  },

  create: (resource, params) =>
    httpClient(`${apiUrl}/${resource}`, {
      method: 'POST',
      body: JSON.stringify(params.data),
    }).then(({ json }) => ({
      data: { ...params.data, id: json.id },
    })),

  update: (resource, params) =>
    httpClient(`${apiUrl}/${resource}/${params.id}`, {
      method: 'PATCH',
      body: JSON.stringify(params.data),
    }).then(({ json }) => ({ data: json })),

  updateMany: (resource, params) => {
    const query = {
      id: params.ids,
    };
    return httpClient(`${apiUrl}/${resource}?${queryString.stringify(query)}`, {
      method: 'PATCH',
      body: JSON.stringify(params.data),
    }).then(({ json }) => ({ data: json }));
  },

  delete: (resource, params) =>
    httpClient(`${apiUrl}/${resource}/${params.id}`, {
      method: 'DELETE',
    }).then(({ json }) => ({ data: json })),

  deleteMany: (resource, params) => {
    return Promise.all(
      params.ids.map(id =>
        httpClient(`${apiUrl}/${resource}/${id}`, {
          method: 'DELETE',
        })
      )
    ).then(() => ({ data: params.ids }));
  },
};
