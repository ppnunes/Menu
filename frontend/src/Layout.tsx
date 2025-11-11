import { Layout as RALayout } from 'react-admin';
import { AppBar } from './AppBar';

export const Layout = (props: any) => <RALayout {...props} appBar={AppBar} />;
