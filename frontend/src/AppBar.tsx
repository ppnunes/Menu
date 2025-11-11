import { AppBar as RAAppBar, UserMenu, useGetIdentity } from 'react-admin';
import { Typography, Box } from '@mui/material';
import RestaurantMenuIcon from '@mui/icons-material/RestaurantMenu';

export const AppBar = (props: any) => {
  const { identity } = useGetIdentity();

  return (
    <RAAppBar {...props} userMenu={<UserMenu />}>
      <Box sx={{ flex: 1, display: 'flex', alignItems: 'center', gap: 1 }}>
        <RestaurantMenuIcon />
        <Typography variant="h6" color="inherit" sx={{ flexGrow: 1 }}>
          Menu Admin
        </Typography>
      </Box>
      {identity && (
        <Typography variant="body2" color="inherit" sx={{ marginRight: 2 }}>
          Olá, {identity.fullName}
        </Typography>
      )}
    </RAAppBar>
  );
};
