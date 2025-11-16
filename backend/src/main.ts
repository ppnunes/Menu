import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Habilitar CORS
  app.enableCors();

  // Validação global
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: false, // Permite campos extras mas os ignora
      transform: true,
    }),
  );

  // Configuração do Swagger/OpenAPI
  const config = new DocumentBuilder()
    .setTitle('Menu API')
    .setDescription('API de catálogo de pratos com informações nutricionais')
    .setVersion('1.0')
    .addTag('auth', 'Autenticação')
    .addTag('usuarios', 'Gerenciamento de usuários')
    .addTag('grupos', 'Gerenciamento de grupos (roles)')
    .addTag('pratos', 'Gerenciamento de pratos')
    .addTag('ingredientes', 'Gerenciamento de ingredientes')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  const port = process.env.PORT || 3000;
  await app.listen(port);
  console.log(`🚀 Aplicação rodando em http://localhost:${port}`);
  console.log(`📚 Documentação disponível em http://localhost:${port}/api`);
}

bootstrap();
