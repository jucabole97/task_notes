import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Item } from "./item.entity";
import * as path from 'path';
import * as fs from 'fs/promises';

@Injectable()
export class ItemService {
    constructor(
        @InjectRepository(Item)
        private notesRepo: Repository<Item>,
    ) {}

    async findAll(): Promise<any[]> {
        const items = await this.notesRepo.find();

        const result = await Promise.all(
            items.map(async (item) => {
                if (item.image) {
                    const filePath = path.join(__dirname, '..', item.image);
                    try {
                        const buffer = await fs.readFile(filePath);
                        return {...item, image: buffer.toString('base64')};
                    } catch {
                        return {...item, image: null};
                    }
                }
                return item;
            }),
        );

        return result;
    }

    async create(title: string, type: string, content?: string, image?: string): Promise<Item> {
        const note = this.notesRepo.create({ title, content, type, image });
        return await this.notesRepo.save(note);
    }

    async getById(id: number): Promise<Item | null> {
        return await this.notesRepo.findOne({ where: { id } });
    }
}