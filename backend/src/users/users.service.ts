import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In } from 'typeorm';
import { Usuario } from './usuario.entity';
import { Grupo } from '../grupos/grupo.entity';
import { CreateUsuarioDto, UpdateUsuarioDto } from './dto/usuario.dto';
import * as bcrypt from 'bcrypt';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(Usuario)
    private usuarioRepository: Repository<Usuario>,
    @InjectRepository(Grupo)
    private grupoRepository: Repository<Grupo>,
  ) {}

  async create(createUsuarioDto: CreateUsuarioDto): Promise<Usuario> {
    const existingUser = await this.usuarioRepository.findOne({
      where: { email: createUsuarioDto.email },
    });

    if (existingUser) {
      throw new ConflictException('Email já cadastrado');
    }

    const hashedPassword = await bcrypt.hash(createUsuarioDto.senha, 10);

    const usuario = this.usuarioRepository.create({
      id: uuidv4(),
      nome: createUsuarioDto.nome,
      email: createUsuarioDto.email,
      senha: hashedPassword,
    });

    // Se grupos foram fornecidos, associá-los
    if (createUsuarioDto.grupoIds && createUsuarioDto.grupoIds.length > 0) {
      const grupos = await this.grupoRepository.findBy({
        id: In(createUsuarioDto.grupoIds),
      });

      if (grupos.length !== createUsuarioDto.grupoIds.length) {
        throw new NotFoundException('Um ou mais grupos não foram encontrados');
      }

      usuario.grupos = grupos;
    }

    return this.usuarioRepository.save(usuario);
  }

  async findAll(): Promise<Usuario[]> {
    return this.usuarioRepository.find({
      relations: ['grupos'],
      select: {
        id: true,
        nome: true,
        email: true,
        ativo: true,
        criadoEm: true,
        atualizadoEm: true,
      },
    });
  }

  async findAllWithCount(
    skip: number = 0,
    take: number = 10,
    sortField: string = 'criadoEm',
    sortOrder: 'ASC' | 'DESC' = 'DESC',
  ): Promise<{ data: Usuario[]; total: number }> {
    const [data, total] = await this.usuarioRepository.findAndCount({
      relations: ['grupos'],
      select: {
        id: true,
        nome: true,
        email: true,
        ativo: true,
        criadoEm: true,
        atualizadoEm: true,
      },
      skip,
      take,
      order: {
        [sortField]: sortOrder,
      },
    });

    return { data, total };
  }

  async findOne(id: string): Promise<Usuario> {
    const usuario = await this.usuarioRepository.findOne({
      where: { id },
      relations: ['grupos'],
      select: {
        id: true,
        nome: true,
        email: true,
        ativo: true,
        criadoEm: true,
        atualizadoEm: true,
      },
    });

    if (!usuario) {
      throw new NotFoundException('Usuário não encontrado');
    }

    return usuario;
  }

  async findByEmail(email: string): Promise<Usuario> {
    return this.usuarioRepository.findOne({
      where: { email },
      relations: ['grupos'],
    });
  }

  async update(id: string, updateUsuarioDto: UpdateUsuarioDto): Promise<Usuario> {
    const usuario = await this.findOne(id);

    if (updateUsuarioDto.email && updateUsuarioDto.email !== usuario.email) {
      const existingUser = await this.usuarioRepository.findOne({
        where: { email: updateUsuarioDto.email },
      });

      if (existingUser) {
        throw new ConflictException('Email já cadastrado');
      }
    }

    if (updateUsuarioDto.senha) {
      updateUsuarioDto.senha = await bcrypt.hash(updateUsuarioDto.senha, 10);
    }

    // Atualizar grupos se fornecidos
    if (updateUsuarioDto.grupoIds !== undefined) {
      if (updateUsuarioDto.grupoIds.length > 0) {
        const grupos = await this.grupoRepository.findBy({
          id: In(updateUsuarioDto.grupoIds),
        });

        if (grupos.length !== updateUsuarioDto.grupoIds.length) {
          throw new NotFoundException('Um ou mais grupos não foram encontrados');
        }

        usuario.grupos = grupos;
      } else {
        // Se array vazio, remover todos os grupos
        usuario.grupos = [];
      }
    }

    // Atualizar outros campos
    if (updateUsuarioDto.nome !== undefined) {
      usuario.nome = updateUsuarioDto.nome;
    }
    if (updateUsuarioDto.email !== undefined) {
      usuario.email = updateUsuarioDto.email;
    }
    if (updateUsuarioDto.senha !== undefined) {
      usuario.senha = updateUsuarioDto.senha;
    }
    if (updateUsuarioDto.ativo !== undefined) {
      usuario.ativo = updateUsuarioDto.ativo;
    }

    return this.usuarioRepository.save(usuario);
  }

  async remove(id: string): Promise<void> {
    const usuario = await this.findOne(id);
    await this.usuarioRepository.remove(usuario);
  }
}
