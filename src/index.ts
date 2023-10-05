import { registerPlugin } from '@capacitor/core';

import type { IntellitrustPlugin } from './definitions';

const Intellitrust = registerPlugin<IntellitrustPlugin>('Intellitrust', {
  web: () => import('./web').then(m => new m.IntellitrustWeb()),
});

export * from './definitions';
export { Intellitrust };
