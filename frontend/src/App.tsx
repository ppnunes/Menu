import { Admin, Resource } from 'react-admin';
import { dataProvider } from './dataProvider';
import { authProvider } from './authProvider';
import portugueseMessages from 'ra-language-portuguese';
import polyglotI18nProvider from 'ra-i18n-polyglot';

const i18nProvider = polyglotI18nProvider(() => portugueseMessages, 'pt');

// Icons
import RestaurantIcon from '@mui/icons-material/Restaurant';
import PeopleIcon from '@mui/icons-material/People';
import GroupIcon from '@mui/icons-material/Group';

// Components
import { PratoList, PratoEdit, PratoCreate, PratoShow } from './resources/pratos';
import { UsuarioList, UsuarioEdit, UsuarioCreate, UsuarioShow } from './resources/usuarios';
import { GrupoList, GrupoShow } from './resources/grupos';
import { Dashboard } from './Dashboard';
import { LoginPage } from './LoginPage';
import { Layout } from './Layout';

const App = () => (
  <Admin
    dataProvider={dataProvider}
    authProvider={authProvider}
    i18nProvider={i18nProvider}
    dashboard={Dashboard}
    loginPage={LoginPage}
    layout={Layout}
    title="Menu Online"
  >
    {(permissions) => (
      <>
        {/* Pratos - Público para leitura, admin/nutricionista para escrita */}
        <Resource
          name="pratos"
          list={PratoList}
          edit={permissions === 'administrador' || permissions === 'nutricionista' ? PratoEdit : undefined}
          create={permissions === 'administrador' || permissions === 'nutricionista' ? PratoCreate : undefined}
          show={PratoShow}
          icon={RestaurantIcon}
          options={{ label: 'Pratos' }}
        />

        {/* Usuários - Apenas administrador */}
        {permissions === 'administrador' && (
          <Resource
            name="usuarios"
            list={UsuarioList}
            edit={UsuarioEdit}
            create={UsuarioCreate}
            show={UsuarioShow}
            icon={PeopleIcon}
            options={{ label: 'Usuários' }}
          />
        )}

        {/* Grupos - Apenas administrador (leitura) */}
        {permissions === 'administrador' && (
          <Resource
            name="grupos"
            list={GrupoList}
            show={GrupoShow}
            icon={GroupIcon}
            options={{ label: 'Grupos' }}
          />
        )}
      </>
    )}
  </Admin>
);

export default App;
