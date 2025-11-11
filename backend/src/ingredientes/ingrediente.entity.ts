import {
  Entity,
  Column,
  PrimaryColumn,
  CreateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Prato } from '../pratos/prato.entity';

@Entity('ingrediente')
export class Ingrediente {
  @PrimaryColumn('char', { length: 36 })
  id: string;

  @Column({ name: 'prato_id', type: 'char', length: 36 })
  pratoId: string;

  @Column({ length: 255 })
  nome: string;

  @CreateDateColumn({ name: 'criado_em' })
  criadoEm: Date;

  @ManyToOne(() => Prato, (prato) => prato.ingredientes, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'prato_id' })
  prato: Prato;
}
