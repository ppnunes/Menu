import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Query,
  Res,
} from '@nestjs/common';
import { Response } from 'express';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { PratosService } from './pratos.service';
import { CreatePratoDto, UpdatePratoDto } from './dto/prato.dto';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { TipoPrato, OrigemPrato } from './prato.entity';

@ApiTags('pratos')
@Controller('pratos')
export class PratosController {
  constructor(private readonly pratosService: PratosService) {}

  @Post()
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('administrador', 'nutricionista')
  @ApiOperation({ summary: 'Criar novo prato (administrador e nutricionista)' })
  @ApiResponse({ status: 201, description: 'Prato criado com sucesso' })
  create(@Body() createPratoDto: CreatePratoDto) {
    return this.pratosService.create(createPratoDto);
  }

  @Get()
  @ApiOperation({ summary: 'Listar todos os pratos (público)' })
  @ApiResponse({ status: 200, description: 'Lista de pratos' })
  @ApiQuery({ name: 'tipo', enum: TipoPrato, required: false })
  @ApiQuery({ name: 'origem', enum: OrigemPrato, required: false })
  @ApiQuery({ name: 'q', required: false, description: 'Buscar por nome' })
  @ApiQuery({ name: '_start', required: false })
  @ApiQuery({ name: '_end', required: false })
  @ApiQuery({ name: '_sort', required: false })
  @ApiQuery({ name: '_order', required: false })
  async findAll(
    @Query('tipo') tipo?: TipoPrato,
    @Query('origem') origem?: OrigemPrato,
    @Query('q') q?: string,
    @Query('_start') start?: string,
    @Query('_end') end?: string,
    @Query('_sort') sort?: string,
    @Query('_order') order?: string,
    @Res({ passthrough: true }) res?: Response,
  ) {
    const skip = start ? parseInt(start) : 0;
    const take = end ? parseInt(end) - skip : 10;
    const sortField = sort || 'criadoEm';
    const sortOrder = order?.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    const result = await this.pratosService.findAllWithFilters(
      { tipo, origem, q },
      skip,
      take,
      sortField,
      sortOrder as 'ASC' | 'DESC',
    );

    if (res) {
      res.header('X-Total-Count', result.total.toString());
      res.header('Access-Control-Expose-Headers', 'X-Total-Count');
    }

    return result.data;
  }

  @Get(':id')
  @ApiOperation({ summary: 'Buscar prato por ID (público)' })
  @ApiResponse({ status: 200, description: 'Prato encontrado' })
  @ApiResponse({ status: 404, description: 'Prato não encontrado' })
  findOne(@Param('id') id: string) {
    return this.pratosService.findOne(id);
  }

  @Patch(':id')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('administrador', 'nutricionista')
  @ApiOperation({ summary: 'Atualizar prato (administrador e nutricionista)' })
  @ApiResponse({ status: 200, description: 'Prato atualizado com sucesso' })
  update(@Param('id') id: string, @Body() updatePratoDto: UpdatePratoDto) {
    return this.pratosService.update(id, updatePratoDto);
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('administrador', 'nutricionista')
  @ApiOperation({ summary: 'Deletar prato (administrador e nutricionista)' })
  @ApiResponse({ status: 200, description: 'Prato deletado com sucesso' })
  remove(@Param('id') id: string) {
    return this.pratosService.remove(id);
  }
}
