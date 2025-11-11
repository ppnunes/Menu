import { Controller, Get, Param, UseGuards, Query, Res } from '@nestjs/common';
import { Response } from 'express';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { GruposService } from './grupos.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@ApiTags('grupos')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('grupos')
export class GruposController {
  constructor(private readonly gruposService: GruposService) {}

  @Get()
  @Roles('administrador')
  @ApiOperation({ summary: 'Listar todos os grupos' })
  @ApiResponse({ status: 200, description: 'Lista de grupos' })
  @ApiQuery({ name: '_start', required: false })
  @ApiQuery({ name: '_end', required: false })
  @ApiQuery({ name: '_sort', required: false })
  @ApiQuery({ name: '_order', required: false })
  async findAll(
    @Query('_start') start?: string,
    @Query('_end') end?: string,
    @Query('_sort') sort?: string,
    @Query('_order') order?: string,
    @Res({ passthrough: true }) res?: Response,
  ) {
    const skip = start ? parseInt(start) : 0;
    const take = end ? parseInt(end) - skip : 10;
    const sortField = sort || 'nome';
    const sortOrder = order?.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    const result = await this.gruposService.findAllWithCount(skip, take, sortField, sortOrder as 'ASC' | 'DESC');

    if (res) {
      res.header('X-Total-Count', result.total.toString());
      res.header('Access-Control-Expose-Headers', 'X-Total-Count');
    }

    return result.data;
  }

  @Get(':id')
  @Roles('administrador')
  @ApiOperation({ summary: 'Buscar grupo por ID' })
  @ApiResponse({ status: 200, description: 'Grupo encontrado' })
  @ApiResponse({ status: 404, description: 'Grupo não encontrado' })
  findOne(@Param('id') id: string) {
    return this.gruposService.findOne(id);
  }
}
