import {
  Entity,
  Column,
  PrimaryColumn,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToMany,
} from 'typeorm';
import { Usuario } from '../users/usuario.entity';

@Entity('grupo')
export class Grupo {
  @PrimaryColumn('char', { length: 36 })
  id: string;

  @Column({ length: 100, unique: true })
  nome: string;

  @Column({ type: 'text', nullable: true })
  descricao: string;

  @CreateDateColumn({ name: 'criado_em' })
  criadoEm: Date;

  @UpdateDateColumn({ name: 'atualizado_em' })
  atualizadoEm: Date;

  @ManyToMany(() => Usuario, (usuario) => usuario.grupos)
  usuarios: Usuario[];
}
