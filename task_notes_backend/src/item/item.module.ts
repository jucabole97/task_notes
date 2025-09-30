import { Module } from "@nestjs/common";
import { ItemService } from "./item.service";
import { ItemController } from "./item.controller";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Item } from "./item.entity";
import { NotificationsService } from "src/notifications/notifications.service";

@Module({
    imports: [TypeOrmModule.forFeature([Item])],
    providers: [ItemService, NotificationsService],
    exports: [ItemService],
    controllers: [ItemController]
})
export class NotesModule {}