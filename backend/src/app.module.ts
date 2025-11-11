import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CacheModule } from '@nestjs/cache-manager';
import { redisStore } from 'cache-manager-redis-yet';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { GruposModule } from './grupos/grupos.module';
import { PratosModule } from './pratos/pratos.module';
import { IngredientesModule } from './ingredientes/ingredientes.module';

@Module({
  imports: [
    // Configuração de variáveis de ambiente
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),

    // Configuração do TypeORM (MySQL)
    TypeOrmModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('DB_HOST'),
        port: configService.get('DB_PORT'),
        username: configService.get('DB_USERNAME'),
        password: configService.get('DB_PASSWORD'),
        database: configService.get('DB_DATABASE'),
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: false, // Não sincronizar automaticamente, usar migrations
        logging: configService.get('NODE_ENV') === 'development',
      }),
    }),

    // Configuração do Cache com Redis
    CacheModule.registerAsync({
      isGlobal: true,
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => {
        const store = await redisStore({
          socket: {
            host: configService.get('REDIS_HOST', 'localhost'),
            port: configService.get('REDIS_PORT', 6379),
          },
          password: configService.get('REDIS_PASSWORD') || undefined,
          ttl: configService.get('REDIS_TTL', 300) * 1000, // convertendo para milissegundos
        });
        
        return {
          store: () => store,
        };
      },
    }),

    // Módulos da aplicação
    AuthModule,
    UsersModule,
    GruposModule,
    PratosModule,
    IngredientesModule,
  ],
})
export class AppModule {}
