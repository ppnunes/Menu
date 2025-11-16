import { ApiProperty } from '@nestjs/swagger';
import {
  IsNotEmpty,
  IsString,
  IsEnum,
  IsOptional,
  IsNumber,
  IsBoolean,
  IsArray,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { TipoPrato, OrigemPrato } from '../prato.entity';

export class IngredienteDto {
  @ApiProperty({ example: 'Tomate' })
  @IsString()
  @IsNotEmpty()
  nome: string;
}

export class CreatePratoDto {
  @ApiProperty({ example: 'Lasanha à Bolonhesa' })
  @IsString()
  @IsNotEmpty()
  nome: string;

  @ApiProperty({ enum: TipoPrato, example: TipoPrato.ONIVORO })
  @IsEnum(TipoPrato)
  tipo: TipoPrato;

  @ApiProperty({ enum: OrigemPrato, example: OrigemPrato.ITALIANA })
  @IsEnum(OrigemPrato)
  origem: OrigemPrato;

  @ApiProperty({ example: 'Lasanha tradicional italiana com molho à bolonhesa', required: false })
  @IsString()
  @IsOptional()
  descricao?: string;

  @ApiProperty({ example: 350.5, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  calorias?: number;

  @ApiProperty({ example: 25.3, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  proteinas?: number;

  @ApiProperty({ example: 40.2, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  carboidratos?: number;

  @ApiProperty({ example: 15.8, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  gorduras?: number;

  @ApiProperty({ example: 6.5, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  gordurasSaturadas?: number;

  @ApiProperty({ example: 3.2, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  fibras?: number;

  @ApiProperty({ example: 580.0, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  sodio?: number;

  @ApiProperty({ example: 5.0, required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  acucares?: number;

  @ApiProperty({ type: [IngredienteDto], required: false })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => IngredienteDto)
  @IsOptional()
  ingredientes?: IngredienteDto[];
}

export class UpdatePratoDto {
  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  nome?: string;

  @ApiProperty({ enum: TipoPrato, required: false })
  @IsEnum(TipoPrato)
  @IsOptional()
  tipo?: TipoPrato;

  @ApiProperty({ enum: OrigemPrato, required: false })
  @IsEnum(OrigemPrato)
  @IsOptional()
  origem?: OrigemPrato;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  descricao?: string;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  calorias?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  proteinas?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  carboidratos?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  gorduras?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  gordurasSaturadas?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  fibras?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  sodio?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  acucares?: number;

  @ApiProperty({ required: false })
  @IsBoolean()
  @IsOptional()
  ativo?: boolean;

  @ApiProperty({ type: [IngredienteDto], required: false })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => IngredienteDto)
  @IsOptional()
  ingredientes?: IngredienteDto[];
}
