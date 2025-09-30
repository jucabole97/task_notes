import { Injectable } from "@nestjs/common";
import * as admin from 'firebase-admin';
import { Message } from "firebase-admin/messaging";
import { Type } from "src/item/item.enum";

@Injectable()
export class NotificationsService {
    constructor() {
        const serviceAccount = require('../../firebase-service-account.json');
        const app = admin.apps.length
            ? admin.app()
            : admin.initializeApp({
                credential: admin.credential.cert(serviceAccount),
            });
    }

    async sendPush(id: number, token: string, title: string, type: Type, body?: string) {
        const typeValue: string = type;
        let titleModal: string = `Se ha creado una ${typeValue}: ${title}`;
        const message: Message = {
            notification: {
                title: titleModal,
                body: body,
            },
            token: token,
            data: {
                deeplink: `/note/${id}`,
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
            },
        };
        return admin.messaging().send(message).then((_) => {
            console.log(`Push enviada al dispositivo 🚀: ${message.notification?.title} (${message.token})`);
        });
    }
}