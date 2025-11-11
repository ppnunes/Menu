import { Controller, Get, Param } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { IngredientesService } from './ingredientes.service';

@ApiTags('ingredientes')
@Controller('ingredientes')
export class IngredientesController {
  constructor(private readonly ingredientesService: IngredientesService) {}

  @Get('prato/:pratoId')
  @ApiOperation({ summary: 'Listar ingredientes de um prato' })
  @ApiResponse({ status: 200, description: 'Lista de ingredientes' })
  findByPrato(@Param('pratoId') pratoId: string) {
    return this.ingredientesService.findByPrato(pratoId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Buscar ingrediente por ID' })
  @ApiResponse({ status: 200, description: 'Ingrediente encontrado' })
  @ApiResponse({ status: 404, description: 'Ingrediente não encontrado' })
  findOne(@Param('id') id: string) {
    return this.ingredientesService.findOne(id);
  }
}
