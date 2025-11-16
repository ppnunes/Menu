import { LoginForm } from 'react-admin';
import { Box, Card, CardContent, Typography } from '@mui/material';
import RestaurantMenuIcon from '@mui/icons-material/RestaurantMenu';

export const LoginPage = () => (
  <Box
    sx={{
      display: 'flex',
      flexDirection: 'column',
      minHeight: '100vh',
      alignItems: 'center',
      justifyContent: 'center',
      backgroundImage: 'url(https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80)',
      backgroundRepeat: 'no-repeat',
      backgroundSize: 'cover',
      backgroundPosition: 'center',
    }}
  >
    <Card sx={{ minWidth: 300, maxWidth: 400, width: '90%' }}>
      <Box
        sx={{
          margin: '1em',
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          gap: 1,
        }}
      >
        <RestaurantMenuIcon sx={{ fontSize: 40, color: 'primary.main' }} />
        <Typography variant="h5" component="h1">
          Menu Online
        </Typography>
      </Box>
      <CardContent>
        <LoginForm />
      </CardContent>
    </Card>
  </Box>
);
