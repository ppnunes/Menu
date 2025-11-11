import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PratosService } from './pratos.service';
import { PratosController } from './pratos.controller';
import { Prato } from './prato.entity';
import { Ingrediente } from '../ingredientes/ingrediente.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Prato, Ingrediente])],
  controllers: [PratosController],
  providers: [PratosService],
  exports: [PratosService],
})
export class PratosModule {}
