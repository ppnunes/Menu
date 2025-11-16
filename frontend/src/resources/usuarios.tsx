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
  ReferenceArrayInput,
  AutocompleteArrayInput,
} from 'react-admin';

// List
export const UsuarioList = () => (
  <List>
    <Datagrid rowClick="show">
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
export const UsuarioEdit = () => {
  const transform = (data: any) => {
    // Remover campos que não devem ser enviados ao backend
    const { id, criadoEm, atualizadoEm, grupos, ...cleanData } = data;
    
    // Se senha estiver vazia, remover do payload
    if (cleanData.senha === '' || cleanData.senha === null || cleanData.senha === undefined) {
      delete cleanData.senha;
    }
    
    return cleanData;
  };

  return (
    <Edit transform={transform}>
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
        <ReferenceArrayInput
          source="grupoIds"
          reference="grupos"
          label="Grupos"
        >
          <AutocompleteArrayInput
            optionText="nome"
            optionValue="id"
            fullWidth
            helperText="Selecione os grupos aos quais o usuário pertence"
          />
        </ReferenceArrayInput>
      </SimpleForm>
    </Edit>
  );
};

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
      <ReferenceArrayInput
        source="grupoIds"
        reference="grupos"
        label="Grupos"
      >
        <AutocompleteArrayInput
          optionText="nome"
          optionValue="id"
          fullWidth
          helperText="Selecione os grupos aos quais o usuário pertence"
        />
      </ReferenceArrayInput>
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
