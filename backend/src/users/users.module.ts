import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { Usuario } from './usuario.entity';
import { Grupo } from '../grupos/grupo.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Usuario, Grupo])],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
