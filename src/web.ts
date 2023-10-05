import { WebPlugin } from '@capacitor/core';

import type { IntellitrustPlugin } from './definitions';

export class IntellitrustWeb extends WebPlugin implements IntellitrustPlugin {
  deleteIdentity(options: { args?: any; }) {
    console.log('deleteIdentity', options);
    return options;
  }
  createNewSoftTokenIdentity(options: { args: any; }): any {
    console.log('createNewSoftTokenIdentity', options);
    return options;
  }
  getOTP(options: { args: any; }): any {
    console.log('getOTP', options);
    return options;
  }
  parseNotification(options: { args: any; }): any {
    console.log('parseNotification', options);
    return options;
  }
  completeTransaction(options: { args: any; }): any {
    console.log('completeTransaction', options);
    return options;
  }
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
