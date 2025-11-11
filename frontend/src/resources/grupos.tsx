import {
  List,
  Datagrid,
  TextField,
  DateField,
} from 'react-admin';

// List
export const GrupoList = () => (
  <List>
    <Datagrid>
      <TextField source="nome" label="Nome" />
      <TextField source="descricao" label="Descrição" />
      <DateField source="criadoEm" label="Criado em" showTime />
    </Datagrid>
  </List>
);
