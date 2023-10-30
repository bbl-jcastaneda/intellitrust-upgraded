# intellitrust-up

Intellitrust plugin upgrade

## Install

```bash
npm install intellitrust-up
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`createNewSoftTokenIdentity(...)`](#createnewsofttokenidentity)
* [`getOTP(...)`](#getotp)
* [`parseNotification(...)`](#parsenotification)
* [`completeTransaction(...)`](#completetransaction)
* [`deleteIdentity(...)`](#deleteidentity)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### createNewSoftTokenIdentity(...)

```typescript
createNewSoftTokenIdentity(options: { args: any; }) => Promise<{ value: string; }>
```

| Param         | Type                        |
| ------------- | --------------------------- |
| **`options`** | <code>{ args: any; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### getOTP(...)

```typescript
getOTP(options: { args: any; }) => Promise<{ value: string; }>
```

| Param         | Type                        |
| ------------- | --------------------------- |
| **`options`** | <code>{ args: any; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### parseNotification(...)

```typescript
parseNotification(options: { args: any; }) => Promise<{ value: string; }>
```

| Param         | Type                        |
| ------------- | --------------------------- |
| **`options`** | <code>{ args: any; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### completeTransaction(...)

```typescript
completeTransaction(options: { args: any; }) => Promise<{ value: string; }>
```

| Param         | Type                        |
| ------------- | --------------------------- |
| **`options`** | <code>{ args: any; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### deleteIdentity(...)

```typescript
deleteIdentity(options: { args?: any; }) => any
```

| Param         | Type                         |
| ------------- | ---------------------------- |
| **`options`** | <code>{ args?: any; }</code> |

**Returns:** <code>any</code>

--------------------

</docgen-api>
