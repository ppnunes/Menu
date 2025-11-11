import {
  List,
  Datagrid,
  TextField,
  EmailField,
  Edit,
  Create,
  Show,
  SimpleForm,
  TextInput,
  BooleanInput,
  PasswordInput,
  SimpleShowLayout,
  BooleanField,
  DateField,
  ArrayField,
  SingleFieldList,
  ChipField,
  required,
  email,
  minLength,
} from 'react-admin';

// List
export const UsuarioList = () => (
  <List>
    <Datagrid rowClick="edit">
      <TextField source="nome" label="Nome" />
      <EmailField source="email" label="Email" />
      <BooleanField source="ativo" label="Ativo" />
      <DateField source="criadoEm" label="Criado em" />
      <ArrayField source="grupos" label="Grupos">
        <SingleFieldList>
          <ChipField source="nome" />
        </SingleFieldList>
      </ArrayField>
    </Datagrid>
  </List>
);

// Edit
export const UsuarioEdit = () => (
  <Edit>
    <SimpleForm>
      <TextInput source="nome" label="Nome" validate={[required()]} fullWidth />
      <TextInput
        source="email"
        label="Email"
        validate={[required(), email()]}
        fullWidth
      />
      <PasswordInput
        source="senha"
        label="Nova Senha (deixe em branco para não alterar)"
        fullWidth
      />
      <BooleanInput source="ativo" label="Ativo" />
    </SimpleForm>
  </Edit>
);

// Create
export const UsuarioCreate = () => (
  <Create>
    <SimpleForm>
      <TextInput source="nome" label="Nome" validate={[required()]} fullWidth />
      <TextInput
        source="email"
        label="Email"
        validate={[required(), email()]}
        fullWidth
      />
      <PasswordInput
        source="senha"
        label="Senha"
        validate={[required(), minLength(6)]}
        fullWidth
      />
    </SimpleForm>
  </Create>
);

// Show
export const UsuarioShow = () => (
  <Show>
    <SimpleShowLayout>
      <TextField source="id" label="ID" />
      <TextField source="nome" label="Nome" />
      <EmailField source="email" label="Email" />
      <BooleanField source="ativo" label="Ativo" />
      <DateField source="criadoEm" label="Criado em" showTime />
      <DateField source="atualizadoEm" label="Atualizado em" showTime />
      <ArrayField source="grupos" label="Grupos">
        <SingleFieldList>
          <ChipField source="nome" />
        </SingleFieldList>
      </ArrayField>
    </SimpleShowLayout>
  </Show>
);
