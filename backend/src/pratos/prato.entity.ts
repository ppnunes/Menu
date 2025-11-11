import {
  Entity,
  Column,
  PrimaryColumn,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import { Ingrediente } from '../ingredientes/ingrediente.entity';

export enum TipoPrato {
  VEGANO = 'vegano',
  VEGETARIANO = 'vegetariano',
  ONIVORO = 'onivoro',
}

export enum OrigemPrato {
  BRASILEIRA = 'brasileira',
  FRANCESA = 'francesa',
  INDIANA = 'indiana',
  ITALIANA = 'italiana',
  JAPONESA = 'japonesa',
  MEXICANA = 'mexicana',
  TAILANDESA = 'tailandesa',
  CHINESA = 'chinesa',
  AMERICANA = 'americana',
  OUTRA = 'outra',
}

@Entity('prato')
export class Prato {
  @PrimaryColumn('char', { length: 36 })
  id: string;

  @Column({ length: 255 })
  nome: string;

  @Column({
    type: 'enum',
    enum: TipoPrato,
  })
  tipo: TipoPrato;

  @Column({
    type: 'enum',
    enum: OrigemPrato,
  })
  origem: OrigemPrato;

  @Column({ type: 'text', nullable: true })
  descricao: string;

  // Tabela nutricional
  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  calorias: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  proteinas: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  carboidratos: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  gorduras: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true, name: 'gorduras_saturadas' })
  gordurasSaturadas: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  fibras: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  sodio: number;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  acucares: number;

  @Column({ type: 'boolean', default: true })
  ativo: boolean;

  @CreateDateColumn({ name: 'criado_em' })
  criadoEm: Date;

  @UpdateDateColumn({ name: 'atualizado_em' })
  atualizadoEm: Date;

  @OneToMany(() => Ingrediente, (ingrediente) => ingrediente.prato)
  ingredientes: Ingrediente[];
}
