import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, MinLength, IsBoolean, IsOptional, IsArray } from 'class-validator';

export class CreateUsuarioDto {
  @ApiProperty({ example: 'João da Silva' })
  @IsString()
  @IsNotEmpty()
  nome: string;

  @ApiProperty({ example: 'joao@example.com' })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({ example: 'senha123' })
  @IsString()
  @MinLength(6)
  senha: string;

  @ApiProperty({ example: ['usuario_comum'], type: [String] })
  @IsArray()
  @IsOptional()
  grupoIds?: string[];
}

export class UpdateUsuarioDto {
  @ApiProperty({ example: 'João da Silva', required: false })
  @IsString()
  @IsOptional()
  nome?: string;

  @ApiProperty({ example: 'joao@example.com', required: false })
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiProperty({ example: 'senha123', required: false })
  @IsString()
  @MinLength(6)
  @IsOptional()
  senha?: string;

  @ApiProperty({ example: true, required: false })
  @IsBoolean()
  @IsOptional()
  ativo?: boolean;

  @ApiProperty({ example: ['usuario_comum'], type: [String], required: false })
  @IsArray()
  @IsOptional()
  grupoIds?: string[];
}

export class UsuarioResponseDto {
  @ApiProperty()
  id: string;

  @ApiProperty()
  nome: string;

  @ApiProperty()
  email: string;

  @ApiProperty()
  ativo: boolean;

  @ApiProperty()
  criadoEm: Date;

  @ApiProperty()
  atualizadoEm: Date;

  @ApiProperty({ type: [String] })
  grupos: string[];
}
