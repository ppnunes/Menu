import {
  List,
  Datagrid,
  TextField,
  DateField,
  Show,
  SimpleShowLayout,
} from 'react-admin';

// List
export const GrupoList = () => (
  <List>
    <Datagrid rowClick="show" bulkActionButtons={false}>
      <TextField source="nome" label="Nome" />
      <TextField source="descricao" label="Descrição" />
    </Datagrid>
  </List>
);

// Show
export const GrupoShow = () => (
  <Show>
    <SimpleShowLayout>
      <TextField source="id" label="ID" />
      <TextField source="nome" label="Nome" />
      <TextField source="descricao" label="Descrição" />
      <DateField source="criadoEm" label="Criado em" showTime />
      <DateField source="atualizadoEm" label="Atualizado em" showTime />
    </SimpleShowLayout>
  </Show>
);
