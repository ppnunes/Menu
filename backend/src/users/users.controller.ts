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
import { UsersService } from './users.service';
import { CreateUsuarioDto, UpdateUsuarioDto, UsuarioResponseDto } from './dto/usuario.dto';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@ApiTags('usuarios')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('usuarios')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  @Roles('administrador')
  @ApiOperation({ summary: 'Criar novo usuário (apenas administrador)' })
  @ApiResponse({ status: 201, description: 'Usuário criado com sucesso', type: UsuarioResponseDto })
  create(@Body() createUsuarioDto: CreateUsuarioDto) {
    return this.usersService.create(createUsuarioDto);
  }

  @Get()
  @Roles('administrador', 'nutricionista')
  @ApiOperation({ summary: 'Listar todos os usuários' })
  @ApiResponse({ status: 200, description: 'Lista de usuários', type: [UsuarioResponseDto] })
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
    const sortField = sort || 'criadoEm';
    const sortOrder = order?.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    const result = await this.usersService.findAllWithCount(skip, take, sortField, sortOrder as 'ASC' | 'DESC');

    if (res) {
      res.header('X-Total-Count', result.total.toString());
      res.header('Access-Control-Expose-Headers', 'X-Total-Count');
    }

    return result.data;
  }

  @Get(':id')
  @Roles('administrador', 'nutricionista')
  @ApiOperation({ summary: 'Buscar usuário por ID' })
  @ApiResponse({ status: 200, description: 'Usuário encontrado', type: UsuarioResponseDto })
  @ApiResponse({ status: 404, description: 'Usuário não encontrado' })
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(id);
  }

  @Patch(':id')
  @Roles('administrador')
  @ApiOperation({ summary: 'Atualizar usuário (apenas administrador)' })
  @ApiResponse({ status: 200, description: 'Usuário atualizado com sucesso' })
  update(@Param('id') id: string, @Body() updateUsuarioDto: UpdateUsuarioDto) {
    return this.usersService.update(id, updateUsuarioDto);
  }

  @Delete(':id')
  @Roles('administrador')
  @ApiOperation({ summary: 'Deletar usuário (apenas administrador)' })
  @ApiResponse({ status: 200, description: 'Usuário deletado com sucesso' })
  remove(@Param('id') id: string) {
    return this.usersService.remove(id);
  }
}
