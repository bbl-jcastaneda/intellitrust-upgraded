export interface IntellitrustPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
