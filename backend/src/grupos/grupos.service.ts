import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Grupo } from './grupo.entity';

@Injectable()
export class GruposService {
  constructor(
    @InjectRepository(Grupo)
    private grupoRepository: Repository<Grupo>,
  ) {}

  async findAll(): Promise<Grupo[]> {
    return this.grupoRepository.find();
  }

  async findAllWithCount(
    skip: number = 0,
    take: number = 10,
    sortField: string = 'nome',
    sortOrder: 'ASC' | 'DESC' = 'ASC',
  ): Promise<{ data: Grupo[]; total: number }> {
    const [data, total] = await this.grupoRepository.findAndCount({
      skip,
      take,
      order: {
        [sortField]: sortOrder,
      },
    });

    return { data, total };
  }

  async findOne(id: string): Promise<Grupo> {
    const grupo = await this.grupoRepository.findOne({ where: { id } });
    if (!grupo) {
      throw new NotFoundException('Grupo não encontrado');
    }
    return grupo;
  }

  async findByNome(nome: string): Promise<Grupo> {
    return this.grupoRepository.findOne({ where: { nome } });
  }
}
