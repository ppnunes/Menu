import { Injectable, NotFoundException, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Cache } from 'cache-manager';
import { Prato, TipoPrato, OrigemPrato } from './prato.entity';
import { Ingrediente } from '../ingredientes/ingrediente.entity';
import { CreatePratoDto, UpdatePratoDto } from './dto/prato.dto';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class PratosService {
  constructor(
    @InjectRepository(Prato)
    private pratoRepository: Repository<Prato>,
    @InjectRepository(Ingrediente)
    private ingredienteRepository: Repository<Ingrediente>,
    @Inject(CACHE_MANAGER)
    private cacheManager: Cache,
  ) {}

  async create(createPratoDto: CreatePratoDto): Promise<Prato> {
    const { ingredientes, ...pratoData } = createPratoDto;

    const prato = this.pratoRepository.create({
      id: uuidv4(),
      ...pratoData,
    });

    const savedPrato = await this.pratoRepository.save(prato);

    if (ingredientes && ingredientes.length > 0) {
      const ingredientesEntities = ingredientes.map((ing) =>
        this.ingredienteRepository.create({
          id: uuidv4(),
          pratoId: savedPrato.id,
          nome: ing.nome,
        }),
      );
      await this.ingredienteRepository.save(ingredientesEntities);
    }

    await this.clearCache();
    return this.findOne(savedPrato.id);
  }

  async findAll(
    skip: number = 0,
    take: number = 10,
    sortField: string = 'criadoEm',
    sortOrder: 'ASC' | 'DESC' = 'DESC',
  ): Promise<Prato[]> {
    const cacheKey = `pratos:all:${skip}:${take}:${sortField}:${sortOrder}`;
    const cached = await this.cacheManager.get<Prato[]>(cacheKey);

    if (cached) {
      return cached;
    }

    const pratos = await this.pratoRepository.find({
      relations: ['ingredientes'],
      where: { ativo: true },
      skip,
      take,
      order: {
        [sortField]: sortOrder,
      },
    });

    await this.cacheManager.set(cacheKey, pratos);
    return pratos;
  }

  async findAllWithCount(
    skip: number = 0,
    take: number = 10,
    sortField: string = 'criadoEm',
    sortOrder: 'ASC' | 'DESC' = 'DESC',
  ): Promise<{ data: Prato[]; total: number }> {
    const cacheKey = `pratos:all:count:${skip}:${take}:${sortField}:${sortOrder}`;
    const cached = await this.cacheManager.get<{ data: Prato[]; total: number }>(cacheKey);

    if (cached) {
      return cached;
    }

    const [data, total] = await this.pratoRepository.findAndCount({
      relations: ['ingredientes'],
      where: { ativo: true },
      skip,
      take,
      order: {
        [sortField]: sortOrder,
      },
    });

    const result = { data, total };
    await this.cacheManager.set(cacheKey, result);
    return result;
  }

  async findOne(id: string): Promise<Prato> {
    const cacheKey = `prato:${id}`;
    const cached = await this.cacheManager.get<Prato>(cacheKey);

    if (cached) {
      return cached;
    }

    const prato = await this.pratoRepository.findOne({
      where: { id },
      relations: ['ingredientes'],
    });

    if (!prato) {
      throw new NotFoundException('Prato não encontrado');
    }

    await this.cacheManager.set(cacheKey, prato);
    return prato;
  }

  async findByTipo(tipo: TipoPrato): Promise<Prato[]> {
    const cacheKey = `pratos:tipo:${tipo}`;
    const cached = await this.cacheManager.get<Prato[]>(cacheKey);

    if (cached) {
      return cached;
    }

    const pratos = await this.pratoRepository.find({
      where: { tipo, ativo: true },
      relations: ['ingredientes'],
    });

    await this.cacheManager.set(cacheKey, pratos);
    return pratos;
  }

  async findByOrigem(origem: OrigemPrato): Promise<Prato[]> {
    const cacheKey = `pratos:origem:${origem}`;
    const cached = await this.cacheManager.get<Prato[]>(cacheKey);

    if (cached) {
      return cached;
    }

    const pratos = await this.pratoRepository.find({
      where: { origem, ativo: true },
      relations: ['ingredientes'],
    });

    await this.cacheManager.set(cacheKey, pratos);
    return pratos;
  }

  async searchByName(
    query: string,
    skip: number = 0,
    take: number = 10,
    sortField: string = 'criadoEm',
    sortOrder: 'ASC' | 'DESC' = 'DESC',
  ): Promise<{ data: Prato[]; total: number }> {
    const cacheKey = `pratos:search:${query}:${skip}:${take}:${sortField}:${sortOrder}`;
    const cached = await this.cacheManager.get<{ data: Prato[]; total: number }>(cacheKey);

    if (cached) {
      return cached;
    }

    const queryBuilder = this.pratoRepository
      .createQueryBuilder('prato')
      .leftJoinAndSelect('prato.ingredientes', 'ingredientes')
      .where('prato.ativo = :ativo', { ativo: true })
      .andWhere('LOWER(prato.nome) LIKE LOWER(:query)', { query: `%${query}%` })
      .skip(skip)
      .take(take)
      .orderBy(`prato.${sortField}`, sortOrder);

    const [data, total] = await queryBuilder.getManyAndCount();

    const result = { data, total };
    await this.cacheManager.set(cacheKey, result);
    return result;
  }

  async findAllWithFilters(
    filters: { tipo?: TipoPrato; origem?: OrigemPrato; q?: string },
    skip: number = 0,
    take: number = 10,
    sortField: string = 'criadoEm',
    sortOrder: 'ASC' | 'DESC' = 'DESC',
  ): Promise<{ data: Prato[]; total: number }> {
    const { tipo, origem, q } = filters;
    const cacheKey = `pratos:filters:${tipo || 'all'}:${origem || 'all'}:${q || 'all'}:${skip}:${take}:${sortField}:${sortOrder}`;
    const cached = await this.cacheManager.get<{ data: Prato[]; total: number }>(cacheKey);

    if (cached) {
      return cached;
    }

    const queryBuilder = this.pratoRepository
      .createQueryBuilder('prato')
      .leftJoinAndSelect('prato.ingredientes', 'ingredientes')
      .where('prato.ativo = :ativo', { ativo: true });

    if (tipo) {
      queryBuilder.andWhere('prato.tipo = :tipo', { tipo });
    }

    if (origem) {
      queryBuilder.andWhere('prato.origem = :origem', { origem });
    }

    if (q) {
      queryBuilder.andWhere('LOWER(prato.nome) LIKE LOWER(:query)', { query: `%${q}%` });
    }

    queryBuilder
      .skip(skip)
      .take(take)
      .orderBy(`prato.${sortField}`, sortOrder);

    const [data, total] = await queryBuilder.getManyAndCount();

    const result = { data, total };
    await this.cacheManager.set(cacheKey, result);
    return result;
  }

  async update(id: string, updatePratoDto: UpdatePratoDto): Promise<Prato> {
    const prato = await this.findOne(id);
    const { ingredientes, ...pratoData } = updatePratoDto;

    Object.assign(prato, pratoData);
    await this.pratoRepository.save(prato);

    if (ingredientes !== undefined) {
      await this.ingredienteRepository.delete({ pratoId: id });

      if (ingredientes.length > 0) {
        const ingredientesEntities = ingredientes.map((ing) =>
          this.ingredienteRepository.create({
            id: uuidv4(),
            pratoId: id,
            nome: ing.nome,
          }),
        );
        await this.ingredienteRepository.save(ingredientesEntities);
      }
    }

    await this.clearCache();
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    const prato = await this.findOne(id);
    await this.pratoRepository.remove(prato);
    await this.clearCache();
  }

  private async clearCache(): Promise<void> {
    await this.cacheManager.reset();
  }
}
