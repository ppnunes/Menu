import { Login, LoginForm } from 'react-admin';
import { Box, Card, CardContent, Typography } from '@mui/material';
import RestaurantMenuIcon from '@mui/icons-material/RestaurantMenu';

export const LoginPage = () => (
  <Login
    backgroundImage="https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80"
  >
    <Box
      sx={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '100vh',
      }}
    >
      <Card sx={{ minWidth: 300, marginTop: '6em' }}>
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
  </Login>
);
