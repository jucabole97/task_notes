import { Controller, Get, Post, Body, Param, NotFoundException } from '@nestjs/common';
import { ItemService } from './item.service';
import { NotificationsService } from '../notifications/notifications.service';
import * as fs from 'fs';
import * as path from 'path';
import { Type } from './item.enum';

@Controller('item')
export class ItemController {
    constructor(
        private itemService: ItemService,
        private notificationsService: NotificationsService,
    ) {}

    @Get()
    findAll() {
        return this.itemService.findAll();
    }

    @Post()
    async create(@Body() body: { title: string; content?: string; token: string, type: string, image?: string }) {
        let imagePath: string | undefined;

        if (body.image) {
            const buffer = Buffer.from(body.image, 'base64');
            const fileName = `note_${Date.now()}.png`;
            const uploadDir = path.join(__dirname, '..', 'uploads');

            if (!fs.existsSync(uploadDir)) {
                fs.mkdirSync(uploadDir);
            }

            const filePath = path.join(uploadDir, fileName);
            fs.writeFileSync(filePath, buffer);
            imagePath = fileName;
        }
        
        const note = await this.itemService.create(body.title, body.type, body.content, imagePath);

        if (body.token) {
            const enumValue = Type[body.type.toUpperCase() as keyof typeof Type];
            await this.notificationsService.sendPush(
                note.id,
                body.token,
                body.title,
                enumValue,
                body.content,
            );
        }

        return note;
    }

    @Get(':id')
    async getById(@Param('id') id: string) {
        const item = await this.itemService.getById(+id);
        if (!item) {
            throw new NotFoundException(`Note with id ${id} not found`);
        }
        return item;
    }
}