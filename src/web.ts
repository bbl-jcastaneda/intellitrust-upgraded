import { WebPlugin } from '@capacitor/core';

import type { IntellitrustPlugin } from './definitions';

export class IntellitrustWeb extends WebPlugin implements IntellitrustPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
