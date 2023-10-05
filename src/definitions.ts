export interface IntellitrustPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  createNewSoftTokenIdentity(options:{args:any}): Promise<{ value: string }>;
  getOTP(options:{args:any}): Promise<{ value: string }>;
  parseNotification(options:{args:any}): Promise<{ value: string }>;
  completeTransaction(options:{args:any}): Promise<{ value: string }>;
  deleteIdentity(options:{args?: any}): any;
}
