import {
  List,
  Datagrid,
  TextField,
  Edit,
  Create,
  Show,
  SimpleForm,
  TextInput,
  SelectInput,
  NumberInput,
  ArrayInput,
  SimpleFormIterator,
  SimpleShowLayout,
  NumberField,
  ArrayField,
  SingleFieldList,
  ChipField,
  required,
  useRecordContext,
  FunctionField,
  BooleanInput,
  BooleanField,
  FilterButton,
  TopToolbar,
  CreateButton,
  ExportButton,
  DateField,
} from 'react-admin';
import { Chip, Box, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@mui/material';

// Opções para os campos
const tipoChoices = [
  { id: 'vegano', name: 'Vegano' },
  { id: 'vegetariano', name: 'Vegetariano' },
  { id: 'onivoro', name: 'Onívoro' },
];

const origemChoices = [
  { id: 'brasileira', name: 'Brasileira' },
  { id: 'francesa', name: 'Francesa' },
  { id: 'indiana', name: 'Indiana' },
  { id: 'italiana', name: 'Italiana' },
  { id: 'japonesa', name: 'Japonesa' },
  { id: 'mexicana', name: 'Mexicana' },
  { id: 'tailandesa', name: 'Tailandesa' },
  { id: 'chinesa', name: 'Chinesa' },
  { id: 'americana', name: 'Americana' },
  { id: 'outra', name: 'Outra' },
];

// Badge de tipo
const TipoBadge = () => {
  const record = useRecordContext();
  if (!record) return null;

  const colors: any = {
    vegano: 'success',
    vegetariano: 'info',
    onivoro: 'warning',
  };

  return <Chip label={record.tipo} color={colors[record.tipo] || 'default'} size="small" />;
};

// Componente para exibir tabela nutricional
const TabelaNutricional = () => {
  const record = useRecordContext();
  if (!record) return null;

  const infoNutricional = [
    { nome: 'Calorias', valor: record.calorias, unidade: 'kcal' },
    { nome: 'Proteínas', valor: record.proteinas, unidade: 'g' },
    { nome: 'Carboidratos', valor: record.carboidratos, unidade: 'g' },
    { nome: 'Gorduras', valor: record.gorduras, unidade: 'g' },
    { nome: 'Gorduras Saturadas', valor: record.gordurasSaturadas, unidade: 'g' },
    { nome: 'Fibras', valor: record.fibras, unidade: 'g' },
    { nome: 'Sódio', valor: record.sodio, unidade: 'mg' },
    { nome: 'Açúcares', valor: record.acucares, unidade: 'g' },
  ];

  return (
    <TableContainer component={Paper} sx={{ mt: 2, mb: 2, maxWidth: 600 }}>
      <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell><strong>Nutriente</strong></TableCell>
            <TableCell align="right"><strong>Quantidade por Porção</strong></TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {infoNutricional.map((item) => (
            <TableRow key={item.nome}>
              <TableCell>{item.nome}</TableCell>
              <TableCell align="right">
                {item.valor != null ? `${item.valor} ${item.unidade}` : '-'}
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

// Filtros
const pratoFilters = [
  <SelectInput key="tipo" source="tipo" label="Tipo" choices={tipoChoices} alwaysOn />,
  <SelectInput key="origem" source="origem" label="Origem" choices={origemChoices} />,
  <TextInput key="q" source="q" label="Buscar" alwaysOn />,
];

// Actions personalizadas
const ListActions = () => (
  <TopToolbar>
    <FilterButton />
    <CreateButton />
    <ExportButton />
  </TopToolbar>
);

// List
export const PratoList = () => (
  <List filters={pratoFilters} actions={<ListActions />}>
    <Datagrid rowClick="show" expand={<PratoExpandPanel />}>
      <TextField source="nome" label="Nome" />
      <FunctionField label="Tipo" render={() => <TipoBadge />} />
      <TextField source="origem" label="Origem" />
      <DateField source="criadoEm" label="Criado em" showTime />
      <DateField source="atualizadoEm" label="Atualizado em" showTime />
    </Datagrid>
  </List>
);

// Painel expandível para mostrar detalhes nutricionais na lista
const PratoExpandPanel = () => {
  const record = useRecordContext();
  if (!record) return null;

  return (
    <Box sx={{ p: 2 }}>
      <Box sx={{ mb: 2 }}>
        <strong>Descrição:</strong> {record.descricao || 'Sem descrição'}
      </Box>
      
      <Box sx={{ mb: 2 }}>
        <strong>Informações Nutricionais (por porção):</strong>
      </Box>
      
      <TabelaNutricional />
      
      {record.ingredientes && record.ingredientes.length > 0 && (
        <Box sx={{ mt: 2 }}>
          <strong>Ingredientes:</strong>
          <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap', mt: 1 }}>
            {record.ingredientes.map((ing: any, idx: number) => (
              <Chip key={idx} label={ing.nome} size="small" />
            ))}
          </Box>
        </Box>
      )}
    </Box>
  );
};

// Edit
export const PratoEdit = () => (
  <Edit>
    <SimpleForm>
      <TextInput source="nome" label="Nome" validate={[required()]} fullWidth />
      <SelectInput source="tipo" label="Tipo" choices={tipoChoices} validate={[required()]} />
      <SelectInput
        source="origem"
        label="Origem"
        choices={origemChoices}
        validate={[required()]}
      />
      <TextInput source="descricao" label="Descrição" multiline rows={3} fullWidth />

      <Box sx={{ mt: 2, mb: 2 }}>
        <h3>Informações Nutricionais (por porção)</h3>
      </Box>

      <NumberInput source="calorias" label="Calorias (kcal)" />
      <NumberInput source="proteinas" label="Proteínas (g)" />
      <NumberInput source="carboidratos" label="Carboidratos (g)" />
      <NumberInput source="gorduras" label="Gorduras (g)" />
      <NumberInput source="gordurasSaturadas" label="Gorduras Saturadas (g)" />
      <NumberInput source="fibras" label="Fibras (g)" />
      <NumberInput source="sodio" label="Sódio (mg)" />
      <NumberInput source="acucares" label="Açúcares (g)" />

      <BooleanInput source="ativo" label="Ativo" />

      <ArrayInput source="ingredientes" label="Ingredientes">
        <SimpleFormIterator inline>
          <TextInput source="nome" label="Nome do ingrediente" />
        </SimpleFormIterator>
      </ArrayInput>
    </SimpleForm>
  </Edit>
);

// Create
export const PratoCreate = () => (
  <Create>
    <SimpleForm>
      <TextInput source="nome" label="Nome" validate={[required()]} fullWidth />
      <SelectInput source="tipo" label="Tipo" choices={tipoChoices} validate={[required()]} />
      <SelectInput
        source="origem"
        label="Origem"
        choices={origemChoices}
        validate={[required()]}
      />
      <TextInput source="descricao" label="Descrição" multiline rows={3} fullWidth />

      <Box sx={{ mt: 2, mb: 2 }}>
        <h3>Informações Nutricionais (por porção)</h3>
      </Box>

      <NumberInput source="calorias" label="Calorias (kcal)" />
      <NumberInput source="proteinas" label="Proteínas (g)" />
      <NumberInput source="carboidratos" label="Carboidratos (g)" />
      <NumberInput source="gorduras" label="Gorduras (g)" />
      <NumberInput source="gordurasSaturadas" label="Gorduras Saturadas (g)" />
      <NumberInput source="fibras" label="Fibras (g)" />
      <NumberInput source="sodio" label="Sódio (mg)" />
      <NumberInput source="acucares" label="Açúcares (g)" />

      <ArrayInput source="ingredientes" label="Ingredientes">
        <SimpleFormIterator inline>
          <TextInput source="nome" label="Nome do ingrediente" />
        </SimpleFormIterator>
      </ArrayInput>
    </SimpleForm>
  </Create>
);

// Show
export const PratoShow = () => (
  <Show>
    <SimpleShowLayout>
      <TextField source="nome" label="Nome" />
      <FunctionField label="Tipo" render={() => <TipoBadge />} />
      <TextField source="origem" label="Origem" />
      <TextField source="descricao" label="Descrição" />

      <Box sx={{ mt: 3, mb: 1 }}>
        <h3>Informações Nutricionais (por porção)</h3>
      </Box>

      <TabelaNutricional />

      <BooleanField source="ativo" label="Ativo" />

      <Box sx={{ mt: 3, mb: 1 }}>
        <h3>Ingredientes</h3>
      </Box>

      <ArrayField source="ingredientes">
        <SingleFieldList>
          <ChipField source="nome" />
        </SingleFieldList>
      </ArrayField>
    </SimpleShowLayout>
  </Show>
);
