import { Card, CardContent, CardHeader } from '@mui/material';
import { useGetList, usePermissions } from 'react-admin';
import RestaurantIcon from '@mui/icons-material/Restaurant';
import PeopleIcon from '@mui/icons-material/People';
import { Box, Typography } from '@mui/material';

const StatCard = ({ title, value, icon }: any) => (
  <Card sx={{ minWidth: 200 }}>
    <CardHeader title={title} />
    <CardContent>
      <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <Typography variant="h3">{value}</Typography>
        {icon}
      </Box>
    </CardContent>
  </Card>
);

export const Dashboard = () => {
  const { permissions } = usePermissions();
  const { data: pratos, isLoading: loadingPratos } = useGetList('pratos', {
    pagination: { page: 1, perPage: 1 },
  });
  const { data: usuarios, isLoading: loadingUsuarios } = useGetList(
    'usuarios',
    {
      pagination: { page: 1, perPage: 1 },
    },
    { enabled: permissions === 'administrador' }
  );

  return (
    <Box sx={{ padding: 2 }}>
      <Typography variant="h4" gutterBottom>
        Dashboard - Menu Admin
      </Typography>
      <Typography variant="body1" gutterBottom sx={{ mb: 3 }}>
        Bem-vindo ao sistema de gerenciamento de pratos!
      </Typography>

      <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
        <StatCard
          title="Total de Pratos"
          value={loadingPratos ? '...' : pratos?.length || 0}
          icon={<RestaurantIcon sx={{ fontSize: 40, color: 'primary.main' }} />}
        />

        {permissions === 'administrador' && (
          <StatCard
            title="Total de Usuários"
            value={loadingUsuarios ? '...' : usuarios?.length || 0}
            icon={<PeopleIcon sx={{ fontSize: 40, color: 'secondary.main' }} />}
          />
        )}
      </Box>

      <Card sx={{ mt: 3 }}>
        <CardHeader title="Suas Permissões" />
        <CardContent>
          <Typography variant="body1">
            <strong>Role:</strong> {permissions || 'Carregando...'}
          </Typography>
          <Typography variant="body2" sx={{ mt: 2 }}>
            {permissions === 'administrador' && '✓ Acesso completo ao sistema'}
            {permissions === 'nutricionista' && '✓ Gerenciar pratos e ingredientes'}
            {permissions === 'usuario_comum' && '✓ Visualizar pratos'}
          </Typography>
        </CardContent>
      </Card>
    </Box>
  );
};
